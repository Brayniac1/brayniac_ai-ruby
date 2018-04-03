module BrayniacAI
  class AwsSignedConnection < ActiveResource::Connection
    prepend AwsRequestSigning
  end
end
