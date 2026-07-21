# frozen_string_literal: true

# Optional entry point. `require 'bybit'` loads the REST core only; the
# WebSocket client lives behind a separate `require 'bybit/websocket'` so
# REST-only consumers don't take the `websocket-client-simple` dependency
# at load time.

require 'bybit'
require 'bybit/websocket/client'
