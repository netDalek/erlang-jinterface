java_import "com.ericsson.otp.erlang.OtpErlangFloat"
java_import "com.ericsson.otp.erlang.OtpErlangDouble"
java_import "com.ericsson.otp.erlang.OtpErlangAtom"
java_import "com.ericsson.otp.erlang.OtpErlangList"
java_import "com.ericsson.otp.erlang.OtpErlangBinary"
java_import "com.ericsson.otp.erlang.OtpErlangLong"
java_import "com.ericsson.otp.erlang.OtpErlangString"
java_import "com.ericsson.otp.erlang.OtpErlangTuple"
java_import "com.ericsson.otp.erlang.OtpErlangMap"
java_import "com.ericsson.otp.erlang.OtpErlangObject"

module Erlang
  module Jinterface
    class Coder
      def initialize(options = {})
        @string = options[:string]
      end

      def array_to_erlang(array)
        array.map{|e| to_erlang(e)}.to_java(OtpErlangObject)
      end

      def to_erlang(object)
        case object
        when Symbol
          OtpErlangAtom.new(object.to_s.to_java)
        when Array
          if object.first == :tuple
            OtpErlangTuple.new(array_to_erlang(object)[1..-1])
          else
            OtpErlangList.new(array_to_erlang(object))
          end
        when Integer
          OtpErlangLong.new(object)
        when Float
          OtpErlangDouble.new(object)
        when String
          if object.encoding == Encoding::ASCII_8BIT
            OtpErlangBinary.new(object.bytes.to_a.to_java(Java::byte))
          else
            case @string
            when :binary
              OtpErlangBinary.new(object.bytes.to_a.to_java(Java::byte))
            when :list
              OtpErlangString.new(object)
            end
          end
        when Hash
          OtpErlangMap.new(array_to_erlang(object.keys), array_to_erlang(object.values))
        else
          raise "Unknown type #{object.class}"
        end
      end
    end
  end
end
