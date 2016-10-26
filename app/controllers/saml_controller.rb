class SamlController < ApplicationController
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)

    # We validate the SAML Response and check if the user already exists in the system

    if response.is_valid?
       # authorize_success, log the user
       session[:userid] = response.nameid
       session[:attributes] = response.attributes

       render text: "LOGGED IN : #{response.nameid}"
    else
      authorize_failure  # This method shows an error message
    end
  end

  private

  def fetch_idp_metadata
    OneLogin::RubySaml::IdpMetadataParser.new.parse_remote('http://localhost:3000/sso/metadata.xml')
  end

  def authorize_failure
    render text: 'AUTHORIZED FAILED'
  end

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new

    settings.assertion_consumer_service_url = "http://#{request.host}:3001/sso/consume"
    settings.issuer                         = "http://#{request.host}:3001/"

    settings.idp_entity_id                  = "http://localhost:3000/sso/sign_in"
    settings.idp_sso_target_url             = "http://localhost:3000/sso/sign_in"

    #logout later
    settings.idp_slo_target_url             = "http://localhost:3000/sso/sign_out"
    settings.idp_cert_fingerprint           = '9e9d133aeeb1734606e6ad9e95e8f37c87483e4e78ce9b130caef0d87a9b5042'
    settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Optional for most SAML IdPs
    settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
    # or as an array
    settings.authn_context = [
      "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
      "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
    ]

    # Optional bindings (defaults to Redirect for logout POST for acs)
    settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
    settings.assertion_consumer_logout_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"

    settings
  end
end
