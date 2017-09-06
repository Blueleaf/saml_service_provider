class SamlController < ApplicationController
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    @response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)
    if @response.is_valid?
      # authorize_success, log the user
      session[:attributes]          = @response.attributes
      session[:attributes][:nameid] = @response.nameid
      session[:nameid]              = @response.nameid
      render 'home/index'
    else
      authorize_failure  # This method shows an error message
    end
  end

  private

  def fetch_idp_metadata(settings)
    OneLogin::RubySaml::IdpMetadataParser.new.parse_remote(
      'http://localhost:3000/sso/metadata.xml',
      true,
      settings: settings
    )
  end

  def authorize_failure
    render text: 'AUTHORIZED FAILED'
  end

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new
    settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
    settings = fetch_idp_metadata(settings)

    settings.assertion_consumer_service_url = "http://#{request.host}:3001/sso/consume"
    settings.issuer                         = "http://#{request.host}:3001/"

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
