Logger = Logging::Logger
Levels = Logging::Levels

RSpec.describe Logger do
  describe "#log" do
    context "when called without any parameter" do
      it "don't insert anything in output buffer" do
        buffer = StringIO.new
        logger = Logger.new Levels::DEBUG, buffer
        logger.log

        expect(buffer.string.length).to equal 0
      end
    end

    context "when called with one or more parameters" do
      it "does insert log in output buffer" do
        buffer = StringIO.new
        logger = Logger.new Levels::DEBUG, buffer
        logger.log "Hello"

        expect(buffer.string.length).to be > 0
      end

      it "logs for each parameter" do
        buffer = double("buffer", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer
        
        logger.log "Some", "random", "parameters"
        expect(buffer).to have_received(:<<).exactly(3).times

        logger.log "more", "log"
        expect(buffer).to have_received(:<<).exactly(5).times
      end
    end
  end
end