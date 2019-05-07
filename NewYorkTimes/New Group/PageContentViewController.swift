//
//  PageContentViewController.swift
//  NewYorkTimes
//
//  Created by Win on 5/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit
import WebKit

class PageContentViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var webURL:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.indicatorView.startAnimating()
        let request = URLRequest.init(url: URL(string: self.webURL)!)
        self.webView.accessibilityIdentifier = "webViewId"//AccessibilityIdentifier.webView.rawValue
        
        self.webView.navigationDelegate = self
        self.webView.load(request)
        
    }
  
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
        self.indicatorView.hidesWhenStopped = true
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
