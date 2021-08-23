module Conq
  class Logger
    attr_accessor :min_level
    attr_accessor :output

    def initialize(min_level, output)
      @min_level = min_level
      @output = output
      @shape = "[%{DATE} %{TIME}] %{LEVEL}: %{MESSAGE}"
    end

    def log(level, *input)
      raise TypeError, "Unexpected type for 'level'" unless level.is_a? LogLevel
      return unless level >= min_level

      now = Time.now()
      formatted_date = now.strftime("%Y-%M-%d")
      formatted_time = now.strftime("%H:%M:%S")

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
      log(Levels::DEBUG, *input)
    end

    def info(*input)
      log(Levels::INFO, *input)
    end

    def warning(*input)
      log(Levels::WARNING, *input)
    end

    def error(*input)
      log(Levels::ERROR, *input)
    end

    def critical(*input)
      log(Levels::CRITICAL, *input)
    end

    def config(configuration)
      raise TypeError, "Unexpected type for 'configuration'" unless configuration.is_a? Hash

      @output = configuration[:output] if configuration[:output]
      @shape = configuration[:shape] if configuration[:shape]
      @min_level = configuration[:min_level] if configuration[:min_level]
    end
  end
end