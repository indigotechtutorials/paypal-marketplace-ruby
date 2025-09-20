# Todo list for paypal API wrapper for marketplace

This is a work in progess and needs some focus.

[ ] Create a base class for gem preferably not name conflicting with any other paypal gem or objects. PaypalMarketplace might be a great class name 


[ ] Store credentials on PaypalMarketplace class

PaypalMarketplace.credentials = {
  client_id: "asdf123",
  client_secret: "secret1###",
}

Or

PaypalMarketplace.client_id      = "asdf123"
PaypalMarketplace.client_secret  = "secret1###"

[ ] Add methods for generating signup link using underlying partners api call

https://developer.paypal.com/docs/multiparty/seller-onboarding/before-payment/#generate-a-signup-link

[ ] Theres so many methods on the example request I want to slim it down so we only have to pass the minimal amount possible and create the request and then link them to input there own information like how Stripe checkout works.
