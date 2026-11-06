# SDK Review Fixes Design

## Scope

Correct the defects found while reviewing the `doris-main` branch without
changing unrelated REST behavior or issuing state-changing testnet requests.

## API contract corrections

- Align Alpha Prediction request parameters with the current official API
  documentation.
- `get_prediction_group_stage_detail` accepts required `event_type` and
  optional `group_name`; it sends `eventType` and `groupName`.
- `get_prediction_match_list` keeps required `event_type` and accepts the
  documented optional filters and pagination arguments through keyword args.
- `get_prediction_timeline_stages` requires `event_type`.
- `get_prediction_portfolio_summary` accepts the optional `event_type` filter.
- `get_prediction_price_history` requires singular `token_id` and `interval`.
- Do not preserve aliases for invalid, unreleased 0.1.3 parameter contracts.

## Documentation corrections

- Replace generated `@see` URLs with the actual public documentation routes
  listed in the official sitemap.
- Where no public documentation page exists, omit the dead link and retain an
  explicit note that the endpoint comes from the OpenAPI source.
- Move the 0.1.3 entry below the `# Changelog` introduction and use the
  existing Keep a Changelog heading format.
- Add the newly exposed client services to the README service inventory.

## Tests and verification

- Update generated contract examples to assert the corrected Alpha wire keys.
- Add explicit examples for required arguments and optional filters so a
  self-consistent generated implementation cannot conceal source drift.
- Run the focused examples red before production edits, then green afterward.
- Run the complete RSpec suite, RuboCop, `git diff --check`, and read-only
  testnet calls for corrected Alpha query methods.

## Compatibility and safety

The affected 0.1.3 API is unreleased, so correctness takes precedence over
compatibility with its invalid staged signatures. Testnet verification remains
read-only; no orders, loans, transfers, or account settings are changed.
