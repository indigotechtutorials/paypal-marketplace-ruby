require 'uri'
require 'net/http'

class PaypalMarketplace
  class << self
    attr_accessor :access_token, :credentials, :development

    def create_onboarding_link(tracking_id: nil)
      uri = URI(partner_referral_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, onboarding_headers)
      request.body = onboarding_data(tracking_id: tracking_id).to_json

      response = http.request(request)
    end
  private
    def onboarding_data(**args)
      {
        tracking_id: args[:tracking_id],
        operations: [{
          operation: "API_INTEGRATION",
          api_integration_preference: {
            rest_api_integration: {
              integration_method: "PAYPAL",
              integration_type: "THIRD_PARTY",
              third_party_details: {
                features: [
                    "PAYMENT",
                    "REFUND"
                ]
              }
            }
          }
        }],
        products: [
          "EXPRESS_CHECKOUT"
        ],
        legal_consents: [{
          "type": "SHARE_DATA_CONSENT",
          "granted": true
        }]
      }
    end

    def oauth_headers
      {
        'Content-Type': 'x-www-form-urlencoded'
      }
    end

    def onboarding_headers
      {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{access_token}",
      }
    end

    def partner_referral_url
      "#{base_url_v2}/customer/partner-referrals"
    end

    def oauth_url
      "#{base_url_v1}/oauth2/token"
    end

    def get_access_token
      uri = URI(oauth_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, oauth_headers)
      request.basic_auth(credentials[:client_id], credentials[:client_secret])
      request.set_form_data({ grant_type: "client_credentials" })

      response = http.request(request)
    
      if response.kind_of? Net::HTTPSuccess
        response_json = JSON.parse(response.body)
        @access_token = response_json["access_token"]
      else
        raise Exception.new('The request for oauth token failed for some reason')
      end
    end

    def base_url_v1
      if development == true
        "https://api-m.sandbox.paypal.com/v1"
      else
        "https://api-m.paypal.com/v1"
      end
    end

    def base_url_v2
      if development == true
        "https://api-m.sandbox.paypal.com/v2"
      else
        "https://api-m.paypal.com/v2"
      end
    end
  end
end