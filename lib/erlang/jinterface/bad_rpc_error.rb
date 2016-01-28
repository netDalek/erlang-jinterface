module Erlang
  module Jinterface
    class BadRpcError < RuntimeError
      attr_reader :value

      def initialize(value)
        @value = value
        super(value.inspect)
      end
    end
  end
end
