# frozen_string_literal: true

module Bybit
  module RestApi
    class P2pService < BaseService
      # Get the P2P user account information for the caller.
      #
      # POST /v5/p2p/user/personal/info
      def get_account_info
        @session.sign_request(method: :post, path: '/v5/p2p/user/personal/info', body: {})
      end

      # Get online P2P advertisement list filtered by token, currency and side.
      #
      # POST /v5/p2p/item/online
      #
      # @param token_id [String] Token ID
      # @param currency_id [String] Currency ID
      # @param side [String] Side: 0 buy, 1 sell
      # @option kwargs [String] :page Page number
      # @option kwargs [String] :size Page size
      def get_ads(token_id:, currency_id:, side:, **kwargs)
        params = kwargs.merge(token_id: token_id, currency_id: currency_id, side: side)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/online', body: params)
      end

      # Get simplified list of all P2P orders with optional filters.
      #
      # POST /v5/p2p/order/simplifylist
      #
      # @param page [Integer] Page number
      # @param size [Integer] Page size
      # @option kwargs [Integer] :status Order status filter
      # @option kwargs [String] :begin_time Begin time in milliseconds
      # @option kwargs [String] :end_time End time in milliseconds
      # @option kwargs [String] :token_id Token ID
      # @option kwargs [Integer] :side Side: 0 buy, 1 sell
      def get_all_orders(page:, size:, **kwargs)
        params = kwargs.merge(page: page, size: size)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/simplifylist', body: params)
      end

      # Get the paginated chat message list for a P2P order.
      #
      # POST /v5/p2p/order/message/listpage
      #
      # @param order_id [String] Order ID
      # @param size [String] Page size
      # @option kwargs [String] :current_page Current page number
      def get_chat_messages(order_id:, size:, **kwargs)
        params = kwargs.merge(order_id: order_id, size: size)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/message/listpage', body: params)
      end

      # Get counterparty user info for a P2P order.
      #
      # POST /v5/p2p/user/order/personal/info
      #
      # @option kwargs [String] :original_uid Original user ID of the counterparty.
      # @option kwargs [String] :order_id P2P order ID.
      def get_counterparty_user_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/user/order/personal/info', body: params)
      end

      # Get details of a specific P2P advertisement owned by the caller.
      #
      # POST /v5/p2p/item/info
      #
      # @param item_id [String] Advertisement ID
      def get_my_ad_details(item_id:, **kwargs)
        params = kwargs.merge(item_id: item_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/info', body: params)
      end

      # Get the list of the caller's own P2P advertisements.
      #
      # POST /v5/p2p/item/personal/list
      #
      # @option kwargs [String] :item_id Advertisement ID
      # @option kwargs [String] :status Ad status filter
      # @option kwargs [String] :side Side: 0 buy, 1 sell
      # @option kwargs [String] :token_id Token ID
      # @option kwargs [String] :page Page number
      # @option kwargs [String] :size Page size
      # @option kwargs [String] :currency_id Currency ID
      def get_my_ads(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/personal/list', body: params)
      end

      # Get the details of a specific P2P order.
      #
      # POST /v5/p2p/order/info
      #
      # @param order_id [String] Order ID
      def get_order_detail(order_id:, **kwargs)
        params = kwargs.merge(order_id: order_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/info', body: params)
      end

      # Get simplified list of pending P2P orders with optional filters.
      #
      # POST /v5/p2p/order/pending/simplifylist
      #
      # @param page [Integer] Page number
      # @param size [Integer] Page size
      # @option kwargs [Integer] :status Order status filter
      # @option kwargs [String] :begin_time Begin time in milliseconds
      # @option kwargs [String] :end_time End time in milliseconds
      # @option kwargs [String] :token_id Token ID
      # @option kwargs [Integer] :side Side: 0 buy, 1 sell
      def get_pending_orders(page:, size:, **kwargs)
        params = kwargs.merge(page: page, size: size)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/pending/simplifylist', body: params)
      end

      # Get the current user's P2P payment method list.
      #
      # POST /v5/p2p/user/payment/list
      def get_user_payment
        @session.sign_request(method: :post, path: '/v5/p2p/user/payment/list', body: {})
      end

      # Mark a P2P order as paid by the buyer.
      #
      # POST /v5/p2p/order/pay
      #
      # @param order_id [String] Order ID
      # @param payment_type [String] Payment method type
      # @param payment_id [String] Payment method ID
      def mark_order_as_paid(order_id:, payment_type:, payment_id:, **kwargs)
        params = kwargs.merge(order_id: order_id, payment_type: payment_type, payment_id: payment_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/pay', body: params)
      end

      # Create a new P2P advertisement.
      #
      # POST /v5/p2p/item/create
      #
      # @param token_id [String] Token ID
      # @param currency_id [String] Currency ID
      # @param side [String] Side: 0 buy, 1 sell
      # @param price_type [String] Price type: 0 fixed, 1 floating
      # @param premium [String] Premium value
      # @param price [String] Ad price
      # @param min_amount [String] Minimum order amount
      # @param max_amount [String] Maximum order amount
      # @param remark [String] Ad remark
      # @param trading_preference_set [Hash] Trading preference settings
      # @param payment_ids [Array] Payment method IDs
      # @param quantity [String] Ad quantity
      # @param payment_period [String] Payment period in minutes
      # @param item_type [String] Item type
      def post_ad(token_id:, currency_id:, side:, price_type:, premium:, price:, min_amount:, max_amount:, remark:, trading_preference_set:, payment_ids:, quantity:, payment_period:, item_type:, **kwargs)
        params = kwargs.merge(token_id: token_id, currency_id: currency_id, side: side, price_type: price_type, premium: premium, price: price, min_amount: min_amount, max_amount: max_amount, remark: remark, trading_preference_set: trading_preference_set, payment_ids: payment_ids, quantity: quantity, payment_period: payment_period, item_type: item_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/create', body: params)
      end

      # Release the assets held for a P2P order after payment is confirmed.
      #
      # POST /v5/p2p/order/finish
      #
      # @param order_id [String] Order ID
      def release_assets(order_id:, **kwargs)
        params = kwargs.merge(order_id: order_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/finish', body: params)
      end

      # Cancel/remove an existing P2P advertisement.
      #
      # POST /v5/p2p/item/cancel
      #
      # @param item_id [String] Advertisement ID
      def remove_ad(item_id:, **kwargs)
        params = kwargs.merge(item_id: item_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/cancel', body: params)
      end

      # Send a chat message in a P2P order conversation.
      #
      # POST /v5/p2p/order/message/send
      #
      # @param message [String] Message content
      # @param content_type [String] Message content type
      # @param order_id [String] Order ID
      # @param msg_uuid [String] Message UUID
      # @option kwargs [String] :file_name File name when sending a file
      def send_chat_message(message:, content_type:, order_id:, msg_uuid:, **kwargs)
        params = kwargs.merge(message: message, content_type: content_type, order_id: order_id, msg_uuid: msg_uuid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/order/message/send', body: params)
      end

      # Update or relist an existing P2P advertisement.
      #
      # POST /v5/p2p/item/update
      #
      # @param id [String] Advertisement ID
      # @param price_type [String] Price type: 0 fixed, 1 floating
      # @param premium [String] Premium value
      # @param price [String] Ad price
      # @param min_amount [String] Minimum order amount
      # @param max_amount [String] Maximum order amount
      # @param remark [String] Ad remark
      # @param trading_preference_set [Hash] Trading preference settings
      # @param payment_ids [Array] Payment method IDs
      # @param action_type [String] Action type: MODIFY or ACTIVE
      # @param quantity [String] Ad quantity
      # @param payment_period [String] Payment period in minutes
      def update_ad(id:, price_type:, premium:, price:, min_amount:, max_amount:, remark:, trading_preference_set:, payment_ids:, action_type:, quantity:, payment_period:, **kwargs)
        params = kwargs.merge(id: id, price_type: price_type, premium: premium, price: price, min_amount: min_amount, max_amount: max_amount, remark: remark, trading_preference_set: trading_preference_set, payment_ids: payment_ids, action_type: action_type, quantity: quantity, payment_period: payment_period)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/item/update', body: params)
      end

      # Upload a file for use in a P2P order chat.
      #
      # POST /v5/p2p/oss/upload_file
      #
      # @param upload_file [String] File to upload
      def upload_chat_file(upload_file:, **kwargs)
        params = kwargs.merge(upload_file: upload_file)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/p2p/oss/upload_file', body: params)
      end
    end
  end
end
