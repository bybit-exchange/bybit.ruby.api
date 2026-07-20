# frozen_string_literal: true

module Bybit
  module Utils
    # snake_case <-> camelCase key translation for wire payloads.
    # Bot-family endpoints keep snake_case (identity mapping) — call sites
    # skip WireKeys.camelize. Everyone else runs camelize on the params/body
    # hash right before dispatch.
    #
    # Recursion: batch endpoints (trade#batch_amend_orders,
    # account#batch_set_collateral, etc.) carry Array<Hash> or nested Hash
    # payloads whose inner keys must ALSO be camelized. A non-recursive
    # camelize was the PR#1 blocker (retCode 10001/10004 on every batch call).
    module WireKeys
      # Ruby-reserved-word arg aliases: :end_ → :end on the wire. Codegen
      # emits arg names with the trailing '_'; camelize normalizes them back
      # to the spec name so service methods no longer need per-method
      # `params[:end] = params.delete(:end_)` shims.
      RESERVED_ALIASES = {
        end_: :end, begin_: :begin, class_: :class, next_: :next,
        return_: :return, do_: :do, if_: :if, else_: :else
      }.freeze

      module_function

      # Convert every key of a hash from :some_key / 'some_key' to camelCase.
      # Recurses into Hash and Array-of-Hash values. Non-hash/array values
      # pass through unchanged. Reserved-word aliases (:end_ etc.) get
      # rewritten to their bare form.
      def camelize(hash)
        return hash if hash.nil?

        hash.each_with_object({}) do |(k, v), out|
          out[to_camel(unalias(k))] = camelize_value(v)
        end
      end

      def camelize_value(value)
        case value
        when Hash  then camelize(value)
        when Array then value.map { |el| el.is_a?(Hash) ? camelize(el) : el }
        else value
        end
      end

      def unalias(key)
        return key unless key.is_a?(Symbol) || key.is_a?(String)

        aliased = RESERVED_ALIASES[key.to_s.to_sym]
        return key unless aliased

        key.is_a?(Symbol) ? aliased : aliased.to_s
      end

      def to_camel(key)
        return key unless key.is_a?(Symbol) || key.is_a?(String)

        parts = key.to_s.split('_')
        return key if parts.size < 2

        camel = parts[0] + parts[1..].reject(&:empty?).map(&:capitalize).join
        key.is_a?(Symbol) ? camel.to_sym : camel
      end
    end
  end
end
