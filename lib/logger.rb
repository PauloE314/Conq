module Conq
  class Logger
    attr_accessor :level
    attr_accessor :buffer

    def initialize(level, buffer)
      @level = level
      @buffer = buffer
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

        @buffer << (@log_format % values) + "\n"
      end
    end

    def config(configuration)
      raise TypeError, "Unexpected type of 'configuration'" unless configuration.is_a? Hash

      @level = configuration[:level] if configuration[:level]
      @buffer = configuration[:output] if configuration[:output]
      @log_format = configuration[:format] if configuration[:format]
    end
  end
end