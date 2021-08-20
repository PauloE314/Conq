require_relative "./levels.rb"
require_relative "./logger.rb"

module Conq
  @logger = nil

  def self.init(output = STDOUT)
    @logger = Logger.new output
  end

  def self.get_global
    @logger
  end

  def self.log(level, *input)
    @logger.log level, *input
  end

  def self.debug(message)
    @logger.debug message
  end

  def self.info(message)
    @logger.info message
  end

  def self.warning(message)
    @logger.warning message
  end

  def self.error(message)
    @logger.error message
  end

  def self.critical(message)
    @logger.critical message
  end

  def self.config(configuration)
    @logger.config configuration
  end
end