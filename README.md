# README

This is a sample application implementing Blueleaf's Single Sign-On Servie Provider specification, using Blueleaf as the Identity Provider (IdP).

The key parameters are as follows:

    settings = OneLogin::RubySaml::Settings.new

    settings.idp_entity_id                  = "https://secure.blueleaf.com/sso/sign_in"
    settings.idp_sso_target_url             = "https://secure.blueleaf.com/sso/sign_in"
    settings.idp_cert_fingerprint           = "" # Contact vipsupport@blueleaf.com for our certificate fingerprint
    settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"

Contact vipsupport@blueleaf.com with your SSO initialization endpoint, and your logo.

In plain English:

* Our SSO Entity ID and target url are https://secure.blueleaf.com/sso/sign_in
* The certificate digest is pre-shared statically.
* Use SHA-256 to verify our certificate against this digest: 0de3c93f93e02ad3764f9dbd21a80edac6b1521b6f78bcbfbe9558bce1226c88
* The NameId is stable, and is formatted as an integer.