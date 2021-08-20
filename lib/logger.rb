module Conq
  class Logger
    attr_accessor :output

    def initialize(output)
      @output = output
      @log_format = "[%{DATE} %{TIME}] %{LEVEL}: %{MESSAGE}"
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

        @output << (@log_format % values) + "\n"
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

      @level = configuration[:level] if configuration[:level]
      @output = configuration[:output] if configuration[:output]
      @log_format = configuration[:format] if configuration[:format]
    end
  end
end