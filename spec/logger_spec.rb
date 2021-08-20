Logger = Conq::Logger
Levels = Conq::Levels

RSpec.describe Logger do
  let(:output) { instance_double("IO", :<< => nil)}
  let(:logger) { Logger.new output }

  describe "#output" do
    it "returns the output object passed in the instantitation" do
      expect(logger.output).to be_eql(output)
    end
  end

  describe "#log" do
    context "when called with one parameters" do
      it "don't insert anything in output buffer" do
        logger.log Levels::DEBUG
        expect(output).to_not have_received(:<<)
      end
    end

    context "when called with two or more parameters" do
      context "and the first one is not a Level object" do
        it "raises a TypeError" do
          expect { logger.log "any", "Hello" }.to raise_error(TypeError)
          expect { logger.log 2, "Hello" }.to raise_error(TypeError)
          expect { logger.log [], "Hello" }.to raise_error(TypeError)
          expect { logger.log Object.new, "Hello" }.to raise_error(TypeError)
        end
      end

      context "and the first one is a Level object" do
        it "inserts log in output buffer" do
          logger.log Levels::DEBUG, "Hello"
          expect(output).to have_received(:<<)
        end
  
        it "logs for each parameter" do
          logger.log Levels::DEBUG, "Some", "random", "parameters"
          expect(output).to have_received(:<<).exactly(3).times
  
          logger.log Levels::DEBUG, "more", "log"
          expect(output).to have_received(:<<).exactly(5).times
        end
  
        it "logs with correct message" do
          message = "Hello"

          logger.log Levels::DEBUG, message
          expect(output).to have_received(:<<).with(/#{message}/)
        end
  
        it "calls #to_s method in inputs" do
          input = instance_double("String", :to_s => "Hello")
  
          logger.log Levels::DEBUG, input
          expect(input).to have_received(:to_s)
        end
  
        it "logs with correct level label" do
          Levels.constants.each do |level_name|
            level = Levels.const_get(level_name)
            
            logger.log level, "Hello"
            expect(output).to have_received(:<<).with(/#{level}/i)
          end
        end
  
        it "logs correct timestamp format" do
          date_matcher = /\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]/ #[2021-08-18 12:00:00]
          
          logger.log Levels::DEBUG, "Hello"
          expect(output).to have_received(:<<).with(date_matcher)
        end
  
        it "adds break line at the end of the log" do
          logger.log Levels::DEBUG, "Hello"
          expect(output).to have_received(:<<).with(/.+\n$/)
        end
      end
    end
  end

  describe "#config" do
    context "when a hash is passed as parameter" do
      context "and 'output' is passed" do
        it "changes output object" do
          new_output = instance_double("IO", :<< => nil)

          logger.config output: new_output
          expect(logger.output).to eql(new_output)
        end

        it "enables logs into this new one" do
          new_output = instance_double("IO", :<< => nil)

          logger.config output: new_output
          logger.log Levels::DEBUG, "Hello"
          expect(new_output).to have_received(:<<)
        end
      end

      context "and 'format' is passed" do
        it "changes log format" do
          logger.config format: "%{MESSAGE}\t[%{TIME}]"
          logger.log Levels::DEBUG, "Hello"
          expect(output).to have_received(:<<).with(/Hello\t\[\d{2}:\d{2}:\d{2}\]/)
        end
      end
    end

    context "when a non-hash object is passed" do
      it "raises a TypeError" do
        expect { logger.config "any" }.to raise_error(TypeError)
        expect { logger.config 2 }.to raise_error(TypeError)
        expect { logger.config [] }.to raise_error(TypeError)
        expect { logger.config Object.new }.to raise_error(TypeError)
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
  #   it "logs
  # end
end
