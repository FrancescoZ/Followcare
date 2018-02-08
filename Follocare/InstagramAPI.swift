//
//  InstagramAPI.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//
import Foundation

class InstagramAPI{
    
    typealias Parameters = [String: Any]
    
    public typealias EmptySuccessHandler = () -> Void
    public typealias SuccessHandler<T> = (_ data: T) -> Void
    public typealias FailureHandler = (_ error: Error) -> Void
    
    private enum Keychain {
        static let accessTokenKey = "AccessToken"
    }
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let keychain = KeychainSwift(keyPrefix: "Follocare")
    private let urlSession = URLSession(configuration: .default)
    
    
    var client: (id: String?, redirectURI: String?)?
    
    // MARK: - Initializers
    
    /// Returns a shared instance of Instagram.
    public static let shared = InstagramAPI()
    
    private init() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let clientId = dict["InstagramClientId"] as? String
            let redirectURI = dict["InstagramRedirectURI"] as? String
            client = (clientId, redirectURI)
        }
    }
    
    
    // MARK: - Access Token
    public var isAuthenticated: Bool {
        return retrieveAccessToken() != nil
    }
    
    func storeAccessToken(_ accessToken: String) -> Bool {
        return keychain.set(accessToken, forKey: Keychain.accessTokenKey)
    }
    
    func retrieveAccessToken() -> String? {
        return keychain.get(Keychain.accessTokenKey)
    }
    
    func deleteAccessToken() -> Bool {
        return keychain.delete(Keychain.accessTokenKey)
    }
    
    func request(_ endpoint: String,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil) {
        var urlRequest = URLRequest(url: buildURL(for: endpoint, withParameters: parameters))
        urlRequest.httpMethod = method.rawValue
        
        urlSession.dataTask(with: urlRequest) { (data, _, error) in
            if let data = data {
                DispatchQueue.global(qos: .utility).async {
                    do {
                         print(data)
                    }
                }
            }
            }.resume()
    }
    
    func buildURL(for endpoint: String, withParameters parameters: Parameters? = nil) -> URL {
        var urlComps = URLComponents(string: API.baseURL + endpoint)
        
        var items = [URLQueryItem]()
        
        // Every request needs the access token
        items.append(URLQueryItem(name: "access_token", value: retrieveAccessToken() ?? ""))
        
        parameters?.forEach({ parameter in
            items.append(URLQueryItem(name: parameter.key, value: "\(parameter.value)"))
        })
        
        urlComps!.queryItems = items
        
        return urlComps!.url!
    }
}
