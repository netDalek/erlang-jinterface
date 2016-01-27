#encoding: utf-8
RSpec.describe Erlang::Jinterface::Decoder do
  before(:all) do
    @erl_pid = start_node
    @connection = connect_to_node
  end

  after(:all) do
    stop_node(@erl_pid)
  end

  def send(method)
    subject.to_ruby send_to_node(@connection, method)
  end

  context "default coder" do
    subject { described_class.new }

    it "convert map to hash" do
      expect(send(:map)).to eq({key1: "value", key2: 123})
    end

    it "convert tuple to array" do
      expect(send(:tuple)).to eq([:tuple, :ok, :tuple])
    end

    it "convert atoms" do
      expect(send(:atom)).to eq(:atom)
    end

    it "converts float to numeric" do
      expect(send(:float)).to eq(3.14)
    end

    it "converts long to numeric" do
      expect(send(:long)).to eq(123)
    end

    it "converts binary to byte array" do
      expect(send(:binary)).to eq("binary".bytes.to_a)
    end

    it "converts string to string" do
      expect(send(:string)).to eq("string")
    end
  end

  context "binary to utf_string coder" do
    subject { described_class.new(binary: :utf_string) }

    it "converts binary to string" do
      expect(send(:binary)).to eq("binary")
    end

    it "converts binary to string" do
      expect(send(:utf_binary)).to eq("слово")
    end
  end

  context "binary to ascii_string coder" do
    subject { described_class.new(binary: :ascii_string) }

    it "converts binary to string" do
      expect(send(:binary)).to eq("binary")
    end

    it "converts binary to string" do
      expect(send(:utf_binary)).to eq("слово".force_encoding(Encoding::ASCII_8BIT))
    end
  end

  context "string to array coder" do
    subject { described_class.new(string: :array) }

    it "converts string to array" do
      expect(send(:string)).to eq("string".bytes.to_a)
    end
  end

end