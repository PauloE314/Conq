module Conq
  class Logger
    attr_accessor :level
    attr_accessor :output

    def initialize(level, output)
      @level = level
      @output = output
      @log_format = "[%{DATE} %{TIME}] %{LEVEL}: %{MESSAGE}"
    end

    def log(*input)
      now = Time.now
      formatted_date = now.strftime("%Y-%M-%d")
      formatted_time = now.strftime("%H:%M:%S")

      input.each do |message|
        values = {
          :DATE => formatted_date,
          :TIME => formatted_time,
          :LEVEL => @level,
          :MESSAGE => message
        }

        @output << (@log_format % values) + "\n"
      end
    end

    def config(configuration)
      raise TypeError, "Unexpected type of 'configuration'" unless configuration.is_a? Hash

      @level = configuration[:level] if configuration[:level]
      @output = configuration[:output] if configuration[:output]
      @log_format = configuration[:format] if configuration[:format]
    end
  end
end