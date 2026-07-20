# frozen_string_literal: true

module Bybit
  module Utils
    # snake_case <-> camelCase key translation for wire payloads.
    # Bot-family endpoints keep snake_case (identity mapping) — call sites
    # skip WireKeys.camelize. Everyone else runs camelize on the params/body
    # hash right before dispatch.
    module WireKeys
      module_function

      # Convert every key of a hash from :some_key (Symbol) or 'some_key' (String)
      # to camelCase :someKey / 'someKey'. Non-string / non-symbol keys pass through.
      def camelize(hash)
        return hash if hash.nil?
        hash.each_with_object({}) do |(k, v), out|
          out[to_camel(k)] = v
        end
      end

      def to_camel(key)
        return key unless key.is_a?(Symbol) || key.is_a?(String)
        parts = key.to_s.split('_')
        return key if parts.size < 2
        camel = parts[0] + parts[1..].map { |p| p.empty? ? '' : (p[0].upcase + p[1..].to_s) }.join
        key.is_a?(Symbol) ? camel.to_sym : camel
      end
    end
  end
end
