Logger = Conq::Logger
Levels = Conq::Levels

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

      it "logs with correct message" do
        message = "Hello"
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer

        logger.log message
        expect(buffer).to have_received(:<<).with(/#{message}/)
      end

      it "calls #to_s method in inputs" do
        input = instance_double("String", :to_s => "Hello")
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer

        logger.log input
        expect(input).to have_received(:to_s)
      end

      it "logs with correct level label" do
        Levels.constants.each do |level_name|
          level = Levels.const_get(level_name)
          buffer = instance_double("IO", :<< => nil)
          logger = Logger.new level, buffer

          logger.log "Hello"
          expect(buffer).to have_received(:<<).with(/#{level_name}/i)
        end
      end

      it "logs correct timestamp" do
        buffer = instance_double("IO", :<< => nil)
        logger = Logger.new Levels::DEBUG, buffer
        date_matcher = /\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]/ #[2021-08-18 12:00:00]
        
        logger.log "Hello"
        expect(buffer).to have_received(:<<).with date_matcher
      end
    end
  end
end