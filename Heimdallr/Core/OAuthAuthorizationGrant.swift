import Foundation

/// An authorization grant is a credential representing the resource owner's
/// authorization (to access its protected resources).
public enum OAuthAuthorizationGrant {
    /// A resource owner password credentials grant.
    ///
    /// - parameter username: The resource owner's username.
    /// - parameter password: The resource owner's password.
    case resourceOwnerPasswordCredentials(String, String)

    /// A refresh token grant.
    ///
    /// - parameter refreshToken: The refresh token.
    case refreshToken(String, String)

    /// An extension grant
    ///
    /// - parameter grantType: The grant type URI of the extension grant
    /// - parameter parameters: A dictionary of parameters
    case `extension`(String, [String: String])

    /// Returns the grant's parameters.
    ///
    /// Except for `grant_type`, parameters are specific to each grant:
    ///
    /// - `.ResourceOwnerPasswordCredentials`: `username`, `password`
    /// - `.Refresh`: `refresh_token`
    /// - `.Extension`: `grantType`, `parameters`
    public var parameters: [String: String] {
        switch self {
        case let .resourceOwnerPasswordCredentials(username, password):
            return [
                "grantType": "password",
                "username": username,
                "password": password,
            ]
        case let .refreshToken(refreshToken, sub):
            return [
                "grantType": "refresh_token",
                "refreshToken": refreshToken,
                "sub": sub,
                "scope": "web"
            ]
        case .extension(let grantType, var parameters):
            parameters["grantType"] = grantType
            return parameters
        }
    }
}
