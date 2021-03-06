RSpec.describe Erlang::Jinterface::Connection do
  context "default coder" do
    subject { described_class.new("server@#{hostname}", "qwerty") }

    it "returns rpc result" do
      expect(subject.test_module.echo(1)).to eq(1)
    end

    it "raises BadRpcError" do
      expect{ subject.test_module.error }.to raise_error(Erlang::Jinterface::BadRpcError)
    end
  end

  context "binary to array coder" do
    subject { described_class.new("server@#{hostname}", "qwerty", binary: :array) }
    it "returns binary as array" do
      expect(subject.test_module.echo("test")).to eq("test".bytes.to_a)
    end
  end
end
