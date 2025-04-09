module EasySso
  module SamlClient
    class Setup
      def call(env)
        request = Rack::Request.new(env)
        relay_state = request.params['RelayState'] || request.params['back_url']
        Rails.logger.debug "OmniAuth SAML Setup: RelayState = #{relay_state.inspect}"

        strategy = env['omniauth.strategy']
        strategy.options[:assertion_consumer_service_url] = "https://tech.iworks.kr/easy_sso/saml/consume"
        strategy.options[:issuer] = "https://tech.iworks.kr"
        strategy.options[:request_binding] = "HTTP-POST"  # 추가: HTTP-POST 방식으로 요청

        env  # 반드시 env를 반환합니다.
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml, setup: EasySso::SamlClient::Setup
end
