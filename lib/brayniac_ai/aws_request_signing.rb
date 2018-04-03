module BrayniacAI
  module AwsRequestSigning
    def request(method, path, *arguments)
      case method
      when :patch, :put, :post
        # These request types include a body and headers
        body = arguments.first
        headers = arguments.last
        new_headers = AwsSignatureHeaders.new(method, self.site.merge(path), body, headers)
        super(method, path, body, headers.merge(new_headers))
      else
        # All other request types only include headers
        headers = arguments.first
        new_headers = AwsSignatureHeaders.new(method, self.site.merge(path))
        super(method, path, headers.merge(new_headers))
      end
    end
  end
end
