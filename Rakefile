# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: %i[rubocop spec]

# ── CI release fix ────────────────────────────────────────────────────────────
# `bundle exec rake release` (invoked by rubygems/release-gem@v1) runs
# `release:source_control_push` which does:
#   git push origin refs/heads/<current_branch>
#   git push origin refs/tags/v<version>
# On tag-triggered CI:
#   1. HEAD is detached (checked out at the tag SHA, not a branch), so
#      `refs/heads/HEAD` doesn't exist → `error: src refspec refs/heads/HEAD
#      does not match any` and rake aborts.
#   2. The tag was already pushed by the developer — that's what triggered
#      the workflow. Re-pushing it is redundant.
#
# Neutralize the sub-task on GitHub Actions so rake release proceeds to
# `release:rubygem_push`, which is the step that actually publishes to
# rubygems.org via OIDC. Local `bundle exec rake release` behavior is
# unchanged.
if ENV['GITHUB_ACTIONS'] == 'true'
  if Rake::Task.task_defined?('release:source_control_push')
    Rake::Task['release:source_control_push'].clear
  end
  namespace :release do
    task :source_control_push do
      puts '[release:source_control_push] SKIP on GitHub Actions ' \
           '(HEAD detached at tag; tag already pushed by developer).'
    end
  end
end
