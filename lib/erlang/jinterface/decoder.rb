java_import "com.ericsson.otp.erlang.OtpErlangFloat"
java_import "com.ericsson.otp.erlang.OtpErlangDouble"
java_import "com.ericsson.otp.erlang.OtpErlangAtom"
java_import "com.ericsson.otp.erlang.OtpErlangList"
java_import "com.ericsson.otp.erlang.OtpErlangBinary"
java_import "com.ericsson.otp.erlang.OtpErlangLong"
java_import "com.ericsson.otp.erlang.OtpErlangString"
java_import "com.ericsson.otp.erlang.OtpErlangTuple"
java_import "com.ericsson.otp.erlang.OtpErlangMap"

module Erlang
  module Jinterface
    class Decoder
      def initialize(options = {})
        @binary = options[:binary]
        @string = options[:string]
      end

      def to_ruby(object)
        case object
        when OtpErlangAtom
          object.atomValue.to_sym
        when OtpErlangString
          result = object.stringValue
          case @string
          when :array
            result.bytes.to_a
          else
            result
          end
        when OtpErlangBinary
            result = object.binaryValue.to_a
            case @binary
            when :utf_string
                result.pack('c*').force_encoding('UTF-8')
            when :ascii_string
                result.pack('c*')
            else
                result
            end
        when OtpErlangFloat
          object.floatValue
        when OtpErlangDouble
          object.doubleValue
        when OtpErlangLong
          object.longValue()
        when OtpErlangList
          object.elements.map{|e| to_ruby(e)}
        when OtpErlangTuple
          [:tuple] + object.elements.map{|e| to_ruby(e)}
        when OtpErlangMap
          object.keys.each_with_object({}) do |e, hash|
            hash[to_ruby(e)] = to_ruby(object.get(e))
          end
        else
            raise "Unknown type #{object.class}"
        end
      end
    end
  end
end
