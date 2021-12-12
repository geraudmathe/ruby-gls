class RubyGLS
  class << self
    # Accessor for global configuration.
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config) if block_given?
  end

  class Configuration
    attr_accessor :base_url

    def initialize
      @base_url    = 'https://api.gls-pakete.de/trackandtrace?lang=en'
    end
  end
end
