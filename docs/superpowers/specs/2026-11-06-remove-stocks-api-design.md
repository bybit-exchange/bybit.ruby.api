# Remove Stocks API Design

## Goal

Remove every `/v5/rwa/stocks/*` endpoint from the unreleased Ruby SDK surface
because these APIs are not currently needed.

## Public API changes

- Delete `Bybit::RestApi::StocksService` and its source file.
- Remove the service require, `Client#stocks` reader, and client initializer
  registration.
- Remove all generated request-contract examples for `/v5/rwa/stocks/*`.
- Remove Stocks entries from the README service inventory and the 0.1.3
  changelog.
- Leave unrelated RWA APIs, including Earn RWA endpoints, unchanged.

## Regression protection

Add a focused client-surface example asserting that a new `Bybit::Client` does
not expose `stocks`. Run it before implementation to confirm it fails against
the current client, then remove the Stocks surface and run it again.

## Verification

- Search tracked and untracked project sources for `StocksService`,
  `client.stocks`, and `/v5/rwa/stocks`; no runtime, test, README, or changelog
  references may remain.
- Run the complete RSpec suite and RuboCop.
- Run `git diff --check main` and separately check untracked files.
- Preserve the user's existing staged state; do not stage or commit SDK code.

## Compatibility

This removes an unreleased 0.1.3 API surface. No compatibility alias or hidden
service remains. The existing design and implementation-plan documents may
retain historical discussion of the review, but they are not runtime or public
SDK surfaces.
