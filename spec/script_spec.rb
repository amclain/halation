describe Halation::Script do
  subject { Halation::Script }

  let(:working_dir) { "spec/samples/under_test" }

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
      double.tap do |d|
        allow(d).to receive(:puts)
      end
    }

    before {
      allow(Halation::Engine).to receive(:run) do |opts|
        Halation::Engine.new(opts)
      end
    }

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

    describe "(generated files)" do
      around { |test|
        FileUtils.rm_r(working_dir) if Dir.exists?(working_dir)
        FileUtils.mkdir_p(working_dir)
        Dir.chdir(working_dir) { test.run }
        FileUtils.rm_r(working_dir)
      }

      describe "generate config" do
        specify
      end

      describe "generate roll" do
        let(:args) { %w(--new-roll) }
        let(:roll_path) { "roll.yml" }

        specify do
          File.exists?(roll_path).should eq false

          subject

          File.exists?(roll_path).should eq true
          Halation::Roll.new.load_file(roll_path)
        end

        specify "aborts if another roll exists" do
          File.exists?(roll_path).should eq false

          FileUtils.touch(roll_path)
          File.exists?(roll_path).should eq true

          allow(STDERR).to receive(:puts)
          STDERR.should_receive(:puts).at_least(:once)

          subject
        end
      end
    end

    describe "(live samples)" do
      let(:samples_source) { "spec/samples/set_1" }

      around { |test|
        FileUtils.rm_r(working_dir) if File.exists?(working_dir)
        FileUtils.cp_r(samples_source, working_dir)
        Dir.chdir(working_dir) { test.run }
        FileUtils.rm_r(working_dir)
      }

      describe "config" do
        let(:args) { ["-c", config_file] }

        before { FileUtils.cp_r(Dir["../config/*.yml"], ".") }

        shared_examples :check_config do
          specify { subject.config.artist.should eq artist }
        end

        describe "1" do
          let(:config_file) { "config1.yml" }
          let(:artist) { "Artist 1" }

          include_examples :check_config
        end

        describe "2" do
          let(:config_file) { "config2.yml" }
          let(:artist) { "Artist 2" }

          include_examples :check_config
        end
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

      describe "silent" do
        let(:args) { %w(--silent) }

        specify { subject.silent.should eq true }
      end
    end # live samples
  end
end
