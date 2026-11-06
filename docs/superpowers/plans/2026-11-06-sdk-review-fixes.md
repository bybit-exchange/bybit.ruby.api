# SDK Review Fixes Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct the reviewed API contracts and documentation defects while preserving all unrelated staged SDK work.

**Architecture:** Keep the existing service/session design. Correct only the Alpha method signatures and wire hashes that diverge from the current API contract, add focused service specs, then mechanically repair documentation URLs and release-document structure.

**Tech Stack:** Ruby 3.3, RSpec 3, Faraday 2, RuboCop, YARD comments.

---

### Task 1: Correct Alpha Prediction contracts

**Files:**
- Create: `spec/services/alpha_service_spec.rb`
- Modify: `lib/bybit/rest_api/alpha_service.rb:226-343`
- Modify: `spec/generated/rest_api_generated_spec.rb`

- [ ] **Step 1: Write failing service contract examples**

Add examples using an `instance_double(Bybit::Session)` that require these calls:

```ruby
service.get_prediction_portfolio_summary(event_type: 1)
# body: { eventType: 1 }

service.get_prediction_group_stage_detail(event_type: 1, group_name: 'A')
# body: { eventType: 1, groupName: 'A' }

service.get_prediction_match_list(
  event_type: 1, status: 1, start_time: 1, end_time: 2,
  stage_code: 'GROUP', limit: 10, page_index: 1
)
# body contains every corresponding camelCase key

service.get_prediction_timeline_stages(event_type: 1)
# params: { eventType: 1 }

service.get_prediction_price_history(token_id: 'token-id', interval: '1h')
# body: { tokenId: 'token-id', interval: '1h' }
```

Also assert that omitting `event_type` from timeline stages and omitting
`token_id` from price history raises `ArgumentError` before dispatch.

- [ ] **Step 2: Verify the examples fail for the reviewed defects**

Run:

```bash
bundle exec rspec spec/services/alpha_service_spec.rb
```

Expected: failures showing the old no-argument/`stageCode`/`tokenIds` method contracts.

- [ ] **Step 3: Implement the minimal corrected methods**

Use these public signatures and wire mappings:

```ruby
def get_prediction_portfolio_summary(**kwargs)
  params = Bybit::Utils::WireKeys.camelize(kwargs)
  @session.sign_request(
    method: :post,
    path: '/v5/alpha/prediction/portfolio-summary',
    body: params
  )
end

def get_prediction_price_history(token_id:, interval:)
  params = Bybit::Utils::WireKeys.camelize(tokenId: token_id, interval: interval)
  @session.sign_request(
    method: :post,
    path: '/v5/alpha/prediction/price-history',
    body: params
  )
end

def get_prediction_group_stage_detail(event_type:, **kwargs)
  params = Bybit::Utils::WireKeys.camelize(kwargs.merge(eventType: event_type))
  @session.sign_request(
    method: :post,
    path: '/v5/alpha/prediction/sports/group-stage-detail',
    body: params
  )
end

def get_prediction_match_list(event_type:, **kwargs)
  params = Bybit::Utils::WireKeys.camelize(kwargs.merge(eventType: event_type))
  @session.sign_request(
    method: :post,
    path: '/v5/alpha/prediction/sports/match-list',
    body: params
  )
end

def get_prediction_timeline_stages(event_type:)
  params = Bybit::Utils::WireKeys.camelize(eventType: event_type)
  @session.sign_request(
    method: :get,
    path: '/v5/alpha/prediction/sports/timeline-stages',
    params: params
  )
end
```

Update their YARD parameter comments to match the official request tables.

- [ ] **Step 4: Update generated expectations and verify green**

Replace the affected generated calls with the corrected arguments and expected
wire keys, then run:

```bash
bundle exec rspec spec/services/alpha_service_spec.rb spec/generated/rest_api_generated_spec.rb
```

Expected: all focused examples pass.

### Task 2: Repair documentation surfaces

**Files:**
- Modify: `lib/bybit/rest_api/alpha_service.rb`
- Modify: `lib/bybit/rest_api/event_service.rb`
- Modify: `lib/bybit/rest_api/fiat_service.rb`
- Modify: `lib/bybit/rest_api/institutional_loan_service.rb`
- Modify: `lib/bybit/rest_api/referral_service.rb`
- Modify: `lib/bybit/rest_api/spot_margin_service.rb`
- Modify: `lib/bybit/rest_api/spot_x_service.rb`
- Modify: `lib/bybit/rest_api/spread_trade_service.rb`
- Modify: `lib/bybit/rest_api/stocks_service.rb`
- Modify: `lib/bybit/rest_api/strategy_service.rb`
- Modify: `lib/bybit/rest_api/tax_service.rb`
- Modify: `README.md`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Replace dead YARD links**

Apply the official sitemap route families:

```text
alpha/prediction/sports/* -> alpha/prediction/sports-*
alpha/trade/{purchase,quote,redeem} -> alpha/trade/trade-*
event/* -> event/trade/{order-list,open-order,position,settlement,execution}
fiat/* -> asset/fiat-convert/*
ins-loan/* -> otc/*
referral/* -> referral/referral-*
spot-x/* -> finance/spot-x/* with the published leaf names
spread/* -> spread/{market,trade}/*
strategy/{create,list,stop} -> strategy/{create-strategy,strategy-list,stop-strategy}
```

For Stocks and the private FHT Tax endpoints, remove dead `@see` URLs and add:

```ruby
# @note Generated from the Bybit OpenAPI specification; no public documentation page is currently available.
```

- [ ] **Step 2: Validate every added documentation URL**

Compare all changed `@see` URLs to `https://bybit-exchange.github.io/docs/sitemap.xml`.
Expected: zero changed URLs missing from the sitemap.

- [ ] **Step 3: Repair release documentation**

Move `## [0.1.3] - 2026-11-06` below the changelog introduction, update README's
service inventory with the newly exposed services, and preserve all endpoint
entries and source hashes.

### Task 3: Full verification

**Files:**
- Verify only; no new production files.

- [ ] **Step 1: Run all local gates**

```bash
bundle exec rspec
bundle exec rubocop
git diff --check main
```

Expected: 0 failures, 0 offenses, and no whitespace errors.

- [ ] **Step 2: Run read-only testnet checks**

Use environment-only credentials and call the corrected Alpha query methods.
Do not create orders or change account settings. Confirm request signing works
and record API-level availability or validation responses without printing
credentials or account values.

- [ ] **Step 3: Review the final diff**

Confirm only the approved service, specs, README, CHANGELOG, and documentation
comments changed. Do not stage or commit the user's pre-existing SDK changes.
