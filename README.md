# README

This is a sample application implementing Blueleaf's Single Sign-On Servie Provider specification, using Blueleaf as the Identity Provider (IdP).

Contact vipsupport@blueleaf.com for our certificate fingerprint. The key parameters are as follows:

    settings = OneLogin::RubySaml::Settings.new

    settings.idp_entity_id                  = "https://secure.blueleaf.com/sso/sign_in"
    settings.idp_sso_target_url             = "https://secure.blueleaf.com/sso/sign_in"
    settings.idp_cert_fingerprint           = "" # Contact vipsupport@blueleaf.com for our certificate fingerprint
    settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"

In plain English:

* Our SSO Entity ID and target url are https://secure.blueleaf.com/sso/sign_in
* We use SHA-256 to create a digest (fingerprint) of our certificate for verification.
* The digest is pre-shared statically.
* The NameId is stable, and is formatted as an integer.