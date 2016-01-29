RSpec.describe Erlang::Jinterface::Coder do
  before(:all) do
    @connection = connect_to_node
  end


  let(:decoder) { Erlang::Jinterface::Decoder.new }

  def echo(arg)
    send("echo", arg)
  end

  def send(method, *args)
    decoder.to_ruby send_to_node(@connection, method.to_s, subject.to_erlang(args))
  end

  context "default coder" do
    subject { described_class.new }

    it "convert map to hash" do
      expect(echo({key1: "value", key2: 123})).to eq({key1: "value", key2: 123})
    end

    it "convert tuple to array" do
      expect(echo([:tuple, :ok, :tuple])).to eq([:tuple, :ok, :tuple])
    end

    it "convert atoms" do
      expect(echo(:atom)).to eq(:atom)
    end

    it "converts float to numeric" do
      expect(echo(3.14)).to eq(3.14)
    end

    it "converts long to numeric" do
      expect(echo(123)).to eq(123)
    end

    it "converts binary to byte array" do
      expect(echo("binary")).to eq("binary")
    end

    it "converts Encoding::ASCII_8BIT string to binary" do
      expect(send(:binary, "binary".force_encoding(Encoding::ASCII_8BIT))).to eq(:ok)
    end
  end
end
