//
//  InstagramAuthentication.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import UIKit

class InstagramAuthentication: UIViewController,UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI, API.INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        if InstagramAPI.shared.isAuthenticated == true {
            redirect()
        }
        webView.loadRequest(urlRequest)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let text = webView.request?.url?.absoluteString{
            print(text)
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(API.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    
    func handleAuth(authToken: String) {
        InstagramAPI.shared.storeAccessToken(authToken)
        redirect()
    }
    
    func redirect(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)

    }
}
