# frozen_string_literal: true

RSpec.describe Bybit::RestApi::AlphaService do
  let(:session) { instance_double(Bybit::Session) }
  let(:service) { described_class.new(session) }

  describe '#get_prediction_side_market_list' do
    it 'sends the event ID and camelizes optional filters' do
      expect(session).to receive(:sign_request).with(
        method: :post,
        path: '/v5/alpha/prediction/side-market-list',
        body: { eventId: 'event-id', sortBy: 'volume', marketType: 1, limit: 20, pageIndex: 1 }
      )

      service.get_prediction_side_market_list(
        event_id: 'event-id',
        sort_by: 'volume',
        market_type: 1,
        limit: 20,
        page_index: 1
      )
    end

    it 'rejects a request without an event ID before dispatch' do
      expect(session).not_to receive(:sign_request)

      expect { service.get_prediction_side_market_list }.to raise_error(ArgumentError)
    end
  end

  describe '#get_prediction_portfolio_summary' do
    it 'camelizes optional filters in the request body' do
      expect(session).to receive(:sign_request).with(
        method: :post,
        path: '/v5/alpha/prediction/portfolio-summary',
        body: { eventType: 1 }
      )

      service.get_prediction_portfolio_summary(event_type: 1)
    end
  end

  describe '#get_prediction_group_stage_detail' do
    it 'sends the event type and optional group name' do
      expect(session).to receive(:sign_request).with(
        method: :post,
        path: '/v5/alpha/prediction/sports/group-stage-detail',
        body: { eventType: 1, groupName: 'A' }
      )

      service.get_prediction_group_stage_detail(event_type: 1, group_name: 'A')
    end
  end

  describe '#get_prediction_match_list' do
    it 'camelizes all optional filters in the request body' do
      expect(session).to receive(:sign_request).with(
        method: :post,
        path: '/v5/alpha/prediction/sports/match-list',
        body: {
          eventType: 1,
          status: 1,
          startTime: 1,
          endTime: 2,
          stageCode: 'GROUP',
          limit: 10,
          pageIndex: 1
        }
      )

      service.get_prediction_match_list(
        event_type: 1,
        status: 1,
        start_time: 1,
        end_time: 2,
        stage_code: 'GROUP',
        limit: 10,
        page_index: 1
      )
    end
  end

  describe '#get_prediction_timeline_stages' do
    it 'requires and sends the event type' do
      expect(session).to receive(:sign_request).with(
        method: :get,
        path: '/v5/alpha/prediction/sports/timeline-stages',
        params: { eventType: 1 }
      )

      service.get_prediction_timeline_stages(event_type: 1)
    end

    it 'rejects a request without an event type before dispatch' do
      expect(session).not_to receive(:sign_request)

      expect { service.get_prediction_timeline_stages }.to raise_error(ArgumentError)
    end
  end

  describe '#get_prediction_price_history' do
    it 'requires and sends one token ID and the interval' do
      expect(session).to receive(:sign_request).with(
        method: :post,
        path: '/v5/alpha/prediction/price-history',
        body: { tokenId: 'token-id', interval: '1h' }
      )

      service.get_prediction_price_history(token_id: 'token-id', interval: '1h')
    end

    it 'rejects a request without a token ID before dispatch' do
      expect(session).not_to receive(:sign_request)

      expect { service.get_prediction_price_history(interval: '1h') }.to raise_error(ArgumentError)
    end
  end
end
