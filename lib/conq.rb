require_relative "./levels.rb"
require_relative "./logger.rb"

module Conq
  @logger = nil

  def self.init(output)
    @logger = Logger.new output
  end

  def self.get_global
    @logger
  end

end