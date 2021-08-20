RSpec.describe Conq do
  let(:output) { instance_double("IO", :<< => nil) }
  let(:message) { "Hello" }
  let(:level) { Conq::Levels::INFO }
  
  after(:each) { load(File.expand_path("../lib/conq.rb", File.dirname(__FILE__))) }

  describe "#init" do
    it "creates an instance of the 'Logger' class" do
      logger = Conq.init(output: output)

      expect(logger).to be_a(Conq::Logger)
    end

    it "creates an different instance in every call" do
      logger_1 = Conq.init(output: output)
      logger_2 = Conq.init(output: output)

      expect(logger_1).to_not be_eql(logger_2)
    end

    context "when an output stream is not passed" do
      it "sets the output object to STDOUT" do
        logger = Conq.init()
        
        expect(logger.output).to be_eql(STDOUT)
      end
    end

    context "when min level is passed as parameter" do
      it "sets min_level to the level specified" do
        logger = Conq.init(min_level: level)

        expect(logger.min_level).to be_eql(level)
      end
    end

    context "when min level is not passed as parameter" do
      it "sets min_level to DEBUG" do
        logger = Conq.init()

        expect(logger.min_level).to be_eql(Conq::Levels::DEBUG)
      end
    end
  end

  describe "#get_global" do
    context "when called before #init" do
      it "returns nil" do
        logger = Conq.get_global()

        expect(logger).to be_nil()
      end
    end

    context "when called after #init" do
      it "returns the same object created with #init method" do
        inital_logger = Conq.init(output: output)
        global_logger = Conq.get_global()
  
        expect(global_logger).to be_eql(inital_logger)
      end
  
      it "returns the same obeject every time" do
        Conq.init(output: output)
        logger_1 = Conq.get_global()
        logger_2 = Conq.get_global()
  
        expect(logger_1).to be_eql(logger_2)
      end
    end
  end

  describe "#log" do
    it "calls Logger#log from global logger with correct input" do
      logger = Conq.init(output: output)
      level = Levels::DEBUG
      message = "Hello"

      expect(logger).to receive(:log).with(level, message)
      Conq.log(level, message)
    end
  end

  describe "#debug" do
    it "calls Logger#debug from global logger with correct message" do
      logger = Conq.init(output: output)

      expect(logger).to receive(:debug).with(message)
      Conq.debug(message)
    end
  end

  describe "#info" do
    it "calls Logger#info from global logger with correct message" do
      logger = Conq.init(output: output)

      expect(logger).to receive(:info).with(message)
      Conq.info message
    end
  end

  describe "#warning" do
    it "calls Logger#warning from global logger with correct message" do
      logger = Conq.init(output: output)

      expect(logger).to receive(:warning).with(message)
      Conq.warning message
    end
  end

  describe "#error" do
    it "calls Logger#error from global logger with correct message" do
      logger = Conq.init(output: output)

      expect(logger).to receive(:error).with(message)
      Conq.error message
    end
  end

  describe "#critical" do
    it "calls Logger#critical from global logger with correct message" do
      logger = Conq.init(output: output)

      expect(logger).to receive(:critical).with(message)
      Conq.critical message
    end
  end

  describe "#config" do
    it "calls Logger#config from global logger with correct input" do
      logger = Conq.init(output: output)
      configuration = { output: instance_double("IO", :<< => nil), shape: "%{MESSAGE}" }
      
      expect(logger).to receive(:config).with(configuration)
      Conq.config(configuration)
    end
  end 
end