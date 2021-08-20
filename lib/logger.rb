module Conq
  class Logger
    attr_accessor :output

    def initialize(output)
      @output = output
      @shape = "[%{DATE} %{TIME}] %{LEVEL}: %{MESSAGE}"
    end

    def log(level, *input)
      raise TypeError, "Unexpected type for 'level'" unless level.is_a? LogLevel

      now = Time.now
      formatted_date = now.strftime "%Y-%M-%d" 
      formatted_time = now.strftime "%H:%M:%S" 

      input.each do |message|
        values = {
          :DATE => formatted_date,
          :TIME => formatted_time,
          :LEVEL => level,
          :MESSAGE => message
        }

        @output << (@shape % values) + "\n"
      end
    end

    def debug(*input)
      log Levels::DEBUG, *input
    end

    def info(*input)
      log Levels::INFO, *input
    end

    def warning(*input)
      log Levels::WARNING, *input
    end

    def error(*input)
      log Levels::ERROR, *input
    end

    def critical(*input)
      log Levels::CRITICAL, *input
    end

    def config(configuration)
      raise TypeError, "Unexpected type for 'configuration'" unless configuration.is_a? Hash

      @output = configuration[:output] if configuration[:output]
      @shape = configuration[:shape] if configuration[:shape]
    end
  end
end