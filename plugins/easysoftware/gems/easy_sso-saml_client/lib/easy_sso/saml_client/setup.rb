module EasySso
  module SamlClient
    class Setup

      def self.call(env)
        new(env).setup
      end

      def initialize(env)
        @env = env
      end

      def setup
        @env['omniauth.strategy'].options.merge!(options)
      end

      def options
        settings = EasySso::SamlClient.hash_settings
        settings[:RelayState] = @env['rack.session']['omniauth.RelayState'] if @env['rack.session']
        settings
      end

    end
  end
end
