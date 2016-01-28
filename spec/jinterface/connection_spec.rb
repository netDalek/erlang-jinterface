RSpec.describe Erlang::Jinterface::Connection do

  context "default coder" do
    subject { described_class.new("server@#{hostname}", "qwerty") }

    it "returns rpc result" do
      expect(subject.rpc(:echo, 1)).to eq(1)
    end

    it "raise BadRpcError" do
      expect{ subject.rpc(:error) }.to raise_error(Erlang::Jinterface::BadRpcError)
    end
  end
end
