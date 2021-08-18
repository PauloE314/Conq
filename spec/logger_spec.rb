Logger = Logging::Logger
Levels = Logging::Levels

RSpec.describe Logger do
  describe "#log" do
    context "when called without any parameter" do
      it "don't insert anything in output buffer" do
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer
        logger.log

        expect(buffer).to_not have_received(:<<)
      end
    end

    context "when called with one or more parameters" do
      it "inserts log in output buffer" do
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer
        logger.log "Hello"

        expect(buffer).to have_received(:<<)
      end

      it "logs for each parameter" do
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer
        
        logger.log "Some", "random", "parameters"
        expect(buffer).to have_received(:<<).exactly(3).times

        logger.log "more", "log"
        expect(buffer).to have_received(:<<).exactly(5).times
      end

      it "logs with correct level label" 
      it "logs correct timestamp"
      it "calls #inspec method in inputs"
    end
  end
end