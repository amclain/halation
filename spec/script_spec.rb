describe Halation::Script do
  subject { Halation::Script }

  it "is a singleton" do
    should_not respond_to :new
  end

  describe "has a flag for" do
    subject {
      Halation::Script.run(
        args: args,
        output_stream: output_stream,
        skip_exit: true
      )
    }

    let(:output_stream) {
      double().tap do |d|
        allow(d).to receive(:puts)
      end
    }

    describe "config" do
      specify
    end

    describe "dry run" do
      specify
    end

    describe "print config" do
      specify
    end

    describe "recursive" do
      specify
    end

    describe "print help" do
      let(:args) { %w(--help) }

      specify do
        output_stream.should_receive(:puts).at_least(:once)
        subject
      end
    end
    
    describe "print version" do
      let(:args) { %w(--version) }

      specify do
        output_stream.should_receive(:puts).exactly(:once) do |str|
          str.should include Halation::VERSION
        end

        subject
      end
    end
  end
end
