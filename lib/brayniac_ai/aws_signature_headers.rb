module BrayniacAI
  class AwsSignatureHeaders < Hash
    def initialize(http_method, uri, body = "", headers = {})
      @http_method = http_method
      @uri = uri
      @body = body
      @headers = headers

      set_headers
    end

    private

    attr_reader :http_method, :uri, :body, :headers

    def request_params
      {
        http_method: http_method, 
        url: uri, 
        body: body, 
        headers: headers,
      }
    end

    def set_headers
      # Set self to the signature headers
      signature.headers.each { |key, value| self[key] = value }
    end

    def signature
      signer.sign_request(request_params)
    end

    def signer
      Aws::Sigv4::Signer.new(signer_params)
    end

    def signer_params
      {
        service: "execute-api", # TODO: can this be inferred from the URI?
        region: ENV["AWS_REGION"],
        access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      }
    end
  end
end
