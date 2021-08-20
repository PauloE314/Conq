RSpec.describe Conq do
  let(:output) { instance_double("IO", :<< => nil) }
  
  before(:each) { |example| Conq.init output unless example.metadata[:skip_init] }
  after(:each) { load(File.expand_path("../lib/conq.rb", File.dirname(__FILE__))) }

  describe "#init", skip_init: true do
    it "creates an instance of the 'Logger' class" do
      global_logger = Conq.init output

      expect(global_logger).to be_a(Conq::Logger)
    end
  end

  describe "#get_global", skip_init: true do
    context "when called before #init" do
      it "returns nil" do
        global_logger = Conq.get_global

        expect(global_logger).to be_nil()
      end
    end

    context "when called after #init" do
      it "returns the same object created with #init method" do
        inital_logger = Conq.init output
        global_logger = Conq.get_global
  
        expect(global_logger).to be_eql(inital_logger)
      end
  
      it "returns the same obeject every time" do
        Conq.init output
        logger_1 = Conq.get_global
        logger_2 = Conq.get_global
  
        expect(logger_1).to be_eql(logger_2)
      end
    end
  end

  # describe "#info" do
  #   it "logs in the 'info' mode"
  # end

  # describe "#warning" do
  #   it "logs in the 'warning' mode"
  # end

  # describe "#error" do

  #   it "logs in the 'error' mode"
  # end

  # describe "#critical" do
  #   it "logs in the 'critical' mode"
  # end

  describe "#config" do
    it "calls Logger#config from the global logger"
  end
end