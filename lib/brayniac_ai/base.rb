module BrayniacAI
  class Base < ActiveResource::Base
    API_ENDPOINT = ENV.fetch("BRAYNIAC_AI_API_ENDPOINT")

    self.connection_class = AwsSignedConnection
    self.include_format_in_path = false
    self.site = API_ENDPOINT


    def self.enable_logging
      ActiveSupport::Notifications.subscribe('request.active_resource')  do |name, start, finish, id, payload|
        puts payload
      end
    end
  end
end
