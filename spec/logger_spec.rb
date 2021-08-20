Logger = Conq::Logger
Levels = Conq::Levels

RSpec.describe Logger do
  let(:output) { instance_double("IO", :<< => nil)}

  describe "#log" do
    context "when called without any parameter" do
      it "don't insert anything in output buffer" do
        logger = Logger.new Levels::DEBUG, output

        logger.log
        expect(output).to_not have_received(:<<)
      end
    end

    context "when called with one or more parameters" do
      it "inserts log in output buffer" do
        logger = Logger.new Levels::DEBUG, output

        logger.log "Hello"
        expect(output).to have_received(:<<)
      end

      it "logs for each parameter" do
        logger = Logger.new Levels::DEBUG, output
        
        logger.log "Some", "random", "parameters"
        expect(output).to have_received(:<<).exactly(3).times

        logger.log "more", "log"
        expect(output).to have_received(:<<).exactly(5).times
      end

      it "logs with correct message" do
        message = "Hello"
        logger = Logger.new Levels::DEBUG, output

        logger.log message
        expect(output).to have_received(:<<).with(/#{message}/)
      end

      it "calls #to_s method in inputs" do
        input = instance_double("String", :to_s => "Hello")
        logger = Logger.new Levels::DEBUG, output

        logger.log input
        expect(input).to have_received(:to_s)
      end

      it "logs with correct level label" do
        Levels.constants.each do |level|
          logger = Logger.new level, output

          logger.log "Hello"
          expect(output).to have_received(:<<).with(/#{level}/i)
        end
      end

      it "logs correct timestamp format" do
        logger = Logger.new Levels::DEBUG, output
        date_matcher = /\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]/ #[2021-08-18 12:00:00]
        
        logger.log "Hello"
        expect(output).to have_received(:<<).with(date_matcher)
      end

      it "adds break line at the end of the log" do
        logger = Logger.new Levels::DEBUG, output

        logger.log "Hello"
        expect(output).to have_received(:<<).with(/.+\n$/)
      end
    end
  end

  describe "#config" do
    context "when a hash is passed as parameter" do
      context "and 'output' is passed" do
        it "changes output object" do
          new_output = instance_double("IO", :<< => nil)
          logger = Logger.new Levels::DEBUG, output

          logger.config output: new_output
          expect(logger.output).to eql(new_output)
        end

        it "enables logs into this new one" do
          new_output = instance_double("IO", :<< => nil)
          logger = Logger.new Levels::DEBUG, output

          logger.config output: new_output
          logger.log "Hello"
          expect(new_output).to have_received(:<<)
        end
      end

      context "and 'format' is passed" do
        it "changes log format" do
          logger = Logger.new Levels::DEBUG, output

          logger.config format: "%{MESSAGE}\t[%{TIME}]"
          logger.log "Hello"
          expect(output).to have_received(:<<).with(/Hello\t\[\d{2}:\d{2}:\d{2}\]/)
        end
      end
    end

    context "when a non-hash object is passed" do
      it "raises a TypeError" do
        logger = Logger.new Levels::DEBUG, output

        expect { logger.config "any" }.to raise_error(TypeError)
        expect { logger.config 2 }.to raise_error(TypeError)
        expect { logger.config [] }.to raise_error(TypeError)
      end
    end
  end
end
