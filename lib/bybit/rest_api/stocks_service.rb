# frozen_string_literal: true

module Bybit
  module RestApi
    class StocksService < BaseService
      # 查询 Convert 订单详情
      #
      # GET /v5/rwa/stocks/convert/detail
      #
      # @option kwargs [String] :order_no Convert 订单号；与 `requestId` 二选一
      # @option kwargs [String] :request_id 提交时使用的幂等键；与 `orderNo` 二选一
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/convert/detail
      def get_convert_detail(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/convert/detail', params: params)
      end

      # 获取 Convert 交易对列表
      #
      # GET /v5/rwa/stocks/convert/list
      #
      # @option kwargs [String] :symbol 按标的过滤，如 `AAPL-US`；不传则返回全部
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/convert/list
      def get_convert_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/convert/list', params: params)
      end

      # 提交 Convert 订单（Mint / Redeem）
      #
      # POST /v5/rwa/stocks/convert/submit
      #
      # @param convert_type [String] 方向：MINT（正股→Token）/ REDEEM（Token→正股）
      # @param symbol [String] 底层股票代码，如 `AAPL-US`
      # @param input_amount [String] 输入数量（MINT 时为正股数量，REDEEM 时为 Token 数量）
      # @param front_multiplier [String] 前端快照的转换比例，服务端会与当前值校验
      # @param request_id [String] 幂等键，字母数字与 `-_`，同一 MM 账号下 24 小时内唯一
      # @param flow [String] 链路类型。
      #   - `CEX`：中心化交易所链路，Mint/Burn 均通过 Bybit 主站处理
      #   - `DEX`：去中心化链路，Mint 到指定合约地址；Burn 流程见 `burnScene`
      # @option kwargs [String] :account_type 仅 `REDEEM` 生效，默认 `all`。
      #   - `all`：自动选择账户
      #   - `uta`：指定划入统一交易账户（UTA）
      #   - `fund`：指定划入资金账户
      # @option kwargs [String] :contract_addr MINT 时代币接收地址；DEX Burn DEP 场景时代币提供地址。
      #   DEX 链路 NDP 场景不传。
      # @option kwargs [String] :burn_scene 仅 DEX Burn（`flow=DEX` + `convertType=REDEEM`）时有效。
      #   - `DEP`：走 Bybit 主站（Deposit）Burn——MM 先将 DEX 合约 mStocks 入金到 UID1 再 Redeem
      #   - `NDP`：不经主站（Non-Deposit）Burn——MM DEX 合约授权 TokenIssuer，链上直接划转
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/convert/submit
      def submit_convert(convert_type:, symbol:, input_amount:, front_multiplier:, request_id:, flow:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(convertType: convert_type, symbol: symbol, inputAmount: input_amount, frontMultiplier: front_multiplier, requestId: request_id, flow: flow))
        @session.sign_request(method: :post, path: '/v5/rwa/stocks/convert/submit', body: params)
      end

      # 获取 Multiplier 列表
      #
      # GET /v5/rwa/stocks/market/getMultiplierList
      #
      # @param current [Integer] 当前页码（从 1 开始）
      # @param page_size [Integer] 每页条数，默认 10
      # @option kwargs [String] :symbol 按股票代码过滤，如 `TSLA-US`；不传则返回全部
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/market/getMultiplierList
      def get_multiplier_list(current:, page_size:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(current: current, pageSize: page_size))
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/market/getMultiplierList', params: params)
      end

      # 获取交易日历与市场状态
      #
      # GET /v5/rwa/stocks/market/session
      #
      # @option kwargs [String] :symbol 内部股票代码，如 `TSLA-US`；不传则返回通用日历
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/market/session
      def get_market_session(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/market/session', params: params)
      end

      # 下单（买入 / 卖出股票）
      #
      # POST /v5/rwa/stocks/order
      #
      # @param symbol [String] 股票代码，如 `TSLA-US`、`AAPL-US`
      # @param quote_token [String] 计价资产，当前仅支持 `USDC`
      # @param side [String] 方向
      # @param type [String] 订单类型
      # @param time_in_force [String] 订单有效期：
      #   - `DAY`：当日有效，北美主市场收盘时自动撤单
      #   - `GTC`：撤销前持续有效（Good Till Cancelled）
      #   - `IOC`：立即成交，未成交部分立即取消；仅支持 `LIMIT + 整股 + RTH`
      #   - `SELL` 仅支持 `DAY` / `GTC`
      # @param order_time [Integer] 客户端下单毫秒时间戳
      # @param request_id [String] 幂等键，字母数字与 `-_`，同一 MM 账号下 24 小时内唯一
      # @option kwargs [String] :qty 委托数量（股）。`SELL` 必填；`BUY` 的 `LIMIT`/`STOP`/`STOP_LIMIT` 必填；与 `notional` 互斥
      # @option kwargs [String] :notional 名义额（USDC）。仅 `BUY` 且 `type=MARKET` 时使用；与 `qty` 互斥
      # @option kwargs [String] :limit_price 限价，`type=LIMIT` 或 `STOP_LIMIT` 时必填
      # @option kwargs [String] :stop_price 触发价，`type=STOP` 或 `STOP_LIMIT` 时必填
      # @option kwargs [String] :trading_session 交易时段，默认 `RTH`。
      #   - `RTH`：Regular Trading Hours，正常交易时段
      #   - `24H`：全天候，包含盘前/盘后/夜盘；非 RTH 时段只允许 LIMIT 单
      # @option kwargs [Boolean] :tokenize 成交后是否自动 tokenize，默认 `false`；仅对 `BUY` 生效
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/order
      def place_order(symbol:, quote_token:, side:, type:, time_in_force:, order_time:, request_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol, quoteToken: quote_token, side: side, type: type, timeInForce: time_in_force, orderTime: order_time, requestId: request_id))
        @session.sign_request(method: :post, path: '/v5/rwa/stocks/order', body: params)
      end

      # 撤单
      #
      # POST /v5/rwa/stocks/order/cancel
      #
      # @param order_no [String] 系统订单号
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/order/cancel
      def cancel_order(order_no:)
        params = Bybit::Utils::WireKeys.camelize({ orderNo: order_no })
        @session.sign_request(method: :post, path: '/v5/rwa/stocks/order/cancel', body: params)
      end

      # 查询股票订单详情
      #
      # GET /v5/rwa/stocks/order/detail
      #
      # @option kwargs [String] :order_no 系统订单号；与 `requestId` 二选一
      # @option kwargs [String] :request_id 客户端幂等 ID；与 `orderNo` 二选一
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/order/detail
      def get_order_detail(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/order/detail', params: params)
      end

      # 获取所有正股仓位
      #
      # GET /v5/rwa/stocks/positions
      #
      # @option kwargs [String] :symbol 按标的过滤；不传则返回全部持仓
      # @option kwargs [Boolean] :show_zero 是否返回零持仓，默认 `false`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/rwa/stocks/positions
      def get_positions(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/rwa/stocks/positions', params: params)
      end
    end
  end
end
