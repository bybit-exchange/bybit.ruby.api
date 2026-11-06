# Remove Stocks API Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove every `/v5/rwa/stocks/*` endpoint and the `client.stocks` public surface from the unreleased Ruby SDK.

**Architecture:** Remove the dedicated service at its client composition boundary, then remove its generated request contracts and public documentation. A negative client-surface regression example prevents the service from remaining accidentally exposed.

**Tech Stack:** Ruby 3.3, RSpec 3, RuboCop, generated REST contract specs.

---

### Task 1: Lock the removed client surface with a failing example

**Files:**
- Modify: `spec/bybit_spec.rb`

- [x] **Step 1: Add the negative public-surface example**

Add this example inside `RSpec.describe Bybit`:

```ruby
it 'does not expose the deferred Stocks API' do
  client = Bybit::Client.new

  expect(client).not_to respond_to(:stocks)
end
```

- [x] **Step 2: Run the example and verify RED**

Run:

```bash
bundle exec rspec spec/bybit_spec.rb
```

Expected: the new example fails because the current client still responds to
`stocks`. Ignore the repository-wide coverage gate from a focused run; inspect
the RSpec example result itself.

### Task 2: Remove the Stocks runtime and generated contracts

**Files:**
- Delete: `lib/bybit/rest_api/stocks_service.rb`
- Modify: `lib/bybit/client.rb`
- Modify: `spec/generated/rest_api_generated_spec.rb`
- Modify: `README.md`
- Modify: `CHANGELOG.md`

- [x] **Step 1: Remove the service from client composition**

Delete this require:

```ruby
require 'bybit/rest_api/stocks_service'
```

Remove `:stocks` from `Client`'s `attr_reader` declaration and remove this
initializer entry:

```ruby
stocks: RestApi::StocksService,
```

- [x] **Step 2: Delete the dedicated service implementation**

Delete `lib/bybit/rest_api/stocks_service.rb` in full. Do not move its methods
or retain a compatibility constant.

- [x] **Step 3: Delete every generated Stocks contract example**

From `spec/generated/rest_api_generated_spec.rb`, delete all nine complete
examples whose endpoint comments are:

```text
GET /v5/rwa/stocks/convert/detail
GET /v5/rwa/stocks/convert/list
GET /v5/rwa/stocks/market/getMultiplierList
GET /v5/rwa/stocks/market/session
GET /v5/rwa/stocks/order/detail
GET /v5/rwa/stocks/positions
POST /v5/rwa/stocks/convert/submit
POST /v5/rwa/stocks/order
POST /v5/rwa/stocks/order/cancel
```

- [x] **Step 4: Remove public documentation entries**

Delete this README inventory line:

```markdown
- `client.stocks` — RWA stock conversion, trading, and positions
```

Delete all nine `StocksService#...` entries from the 0.1.3 `Added` section in
`CHANGELOG.md`.

- [x] **Step 5: Verify the focused client example is GREEN**

Run:

```bash
bundle exec rspec spec/bybit_spec.rb
```

Expected: all examples in `spec/bybit_spec.rb` pass. The focused command may
still exit nonzero only because the global SimpleCov thresholds require the
complete suite.

### Task 3: Prove complete removal and run project gates

**Files:**
- Verify only.

- [x] **Step 1: Search for remaining public/runtime references**

Run:

```bash
rg -n -i 'StocksService|client\.stocks|/v5/rwa/stocks' \
  README.md CHANGELOG.md lib spec
```

Expected: no matches.

- [x] **Step 2: Run the complete test and lint gates**

Run:

```bash
bundle exec rspec
bundle exec rubocop
```

Expected: zero RSpec failures, coverage gates pass, and RuboCop reports no
offenses.

- [x] **Step 3: Check whitespace and final scope**

Run:

```bash
git diff --check main
rg -n '[[:blank:]]+$' spec/bybit_spec.rb docs/superpowers/plans/2026-11-06-remove-stocks-api.md
git status --short
```

Expected: no whitespace matches or errors. Confirm the existing staged state
is preserved and SDK changes remain uncommitted.
