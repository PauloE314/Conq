require_relative "./levels.rb"
require_relative "./logger.rb"

module Conq
  @logger = nil

  class << self
    def init(min_level: Levels::DEBUG, output: STDOUT)
      @logger = Logger.new(min_level, output)
    end

    def get_global()
      @logger
    end

    def log(level, *input)
      @logger.log(level, *input)
    end

    def debug(message)
      @logger.debug(message)
    end

    def info(message)
      @logger.info(message)
    end

    def warning(message)
      @logger.warning(message)
    end

    def error(message)
      @logger.error(message)
    end

    def critical(message)
      @logger.critical(message)
    end

    def config(configuration)
      @logger.config(configuration)
    end
  end
end
