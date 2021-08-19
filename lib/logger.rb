module Conq
  class Logger
    attr_accessor :level
    attr_accessor :buffer

    def initialize(level, buffer)
      @level = level
      @buffer = buffer
    end

    def log(*input)
      formatted_date = Time.now.strftime("%Y-%M-%d %H:%M:%S")

      input.each do |data|
        @buffer << "[#{formatted_date}] #{@level.to_s}: #{data.to_s}\n"
      end
    end

    def config(configuration)
      raise TypeError, "Unexpected type of 'configuration'" unless configuration.is_a? Hash

      # To Do
    end
  end
end