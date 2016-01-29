module Erlang
  module Jinterface
    class Connection
      def initialize(node_name, cookie, options = {})
        @coder = Erlang::Jinterface::Coder.new(options)
        @decoder = Erlang::Jinterface::Decoder.new(options)
        client = OtpSelf.new(SecureRandom.hex, cookie) 
        other  = OtpPeer.new(node_name)
        @connection = client.connect(other)
      end

      def rpc(mod, method, args = [])
        @connection.sendRPC(mod.to_s, method.to_s, @coder.to_erlang(args))
        @decoder.to_ruby(@connection.receiveRPC).tap do |result|
          if result.is_a?(Array) && result.count == 3 && result.take(2) == [:tuple, :badrpc]
            raise BadRpcError.new(result.last)
          end
        end
      end

      def method_missing(method)  
        ModuleProxy.new(self, method)
      end  

      class ModuleProxy
        def initialize(connection, mod)
          @connection = connection
          @mod = mod
        end

        def rpc(method, args = [])
          @connection.rpc(@mod, method, args)
        end

        def method_missing(method, *args)  
          rpc(method, args)
        end  
      end
    end
  end
end
