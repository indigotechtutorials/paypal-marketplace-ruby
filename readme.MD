# Paypal marketplace API wrapper Ruby

A ruby gem that wraps the Paypal Partner Referrals API

This allows you to onboard users similar to Stripe connect and allow them to sell products on your platform and get payed via Paypal

This gem will be very simple atleast for now as it wraps only the API call to the [Paypal Partner Referrals API](https://developer.paypal.com/api/partner-referrals/v2/)

This can be used in any Ruby project so its not only for Rails.

Note: For this to work you must be an approved partner or else you will recieve an unauthorized response when trying to create the onboarding link

### How to use

Get your API keys from the [Paypal developer dashboard](https://developer.paypal.com/dashboard/).

Next set your credentials on the PaypalMarketplace class somewhere in your app. If you are using the Ruby on Rails framework, I suggest creating an initializer `config/initializers/paypal_marketplace.rb` where you can set this value and Rails will automatically load it when you run the server.

```ruby
  PaypalMarketplace.credentials = {
    client_id: "yourclientid",
    client_secret: "yourclientsecret",
  }
```

To create the onboarding link you can simply call this method on the paypal marketplace class

```ruby
PaypalMarketplace.create_onboarding_link
```

You can pass a tracking id param to store a id or value on the call to track the user you are creating the link for this could be a user id or email or similar value.

```ruby
PaypalMarketplace.create_onboarding_link(tracking_id: "user_1")
```


### What happens when you make the call

We first have to obtain an access token so we make an initial call to the paypal oauth API and get a valid token

Then we take that token and make a request to the partner referral API to generate the signup link.

### Development mode

To enable development mode you must set the development key on the PaypalMarketplace class to true. This will tell the gem to use the sandbox API url for testing out your integration locally.

```ruby
  PaypalMarketplace.development = true
```

If you are using Rails you can pass Rails.env.development? to this to dynamically set it to true if you are in development

```ruby
  PaypalMarketplace.development = Rails.env.development?
```