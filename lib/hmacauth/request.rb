module HMACAuth
  class Request < Rack::Request
    def has_valid_params?
      self.params.has_key?("client_id") && self.env.has_key?("HTTP_HMAC_SIGNATURE")
    end

    def client_id
      self.params["client_id"]
    end

    def signatures_match?(private_key)
      generate_signature(private_key) == self.env['HTTP_HMAC_SIGNATURE']
    end

    def generate_signature(private_key)
      data = self.env['REQUEST_METHOD'] + self.env['REQUEST_URI']
      encrypt_data(private_key, data)
    end

    private

    def encrypt_data(key, data)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), key, data)
    end
  end
end