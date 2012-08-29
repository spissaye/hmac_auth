require 'hmacauth/request'

module HMACAuth
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @request = HMACAuth::Request.new(env)
      if @request.has_valid_params?
        if valid_client?
          if @request.signatures_match?(@client.private_key)
            @app.call(env)
          else
            [401, {}, ["Unauthorized. Invalid Signature."]]
          end
        else
          [401, {}, ["Unauthorized. Invalid Client."]]
        end
      else
        [401, {}, ["Unauthorized."]]
      end
    end

    private

    def valid_client?
      @client = Client.find_by_client_id(@request.client_id)
    end

  end
end