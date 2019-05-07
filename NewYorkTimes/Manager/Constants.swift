//
//  Constanst.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let domainName = "https://www.nytimes.com"
    //static let url = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=f7MUkCiSXA8CrbEIFOFFchDoWK5SQrMX&q=singapore&page=1"
    static let searchUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=f7MUkCiSXA8CrbEIFOFFchDoWK5SQrMX&q=%@&page=%@"
    //static let searchUrl =String(format:url+"&q=%@&page=%@")
    
    struct Date {
        static let API_DATE_FORMAT: String = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let DATE_FORMAT : String = "dd-MMM-yyyy"
        static let DATETIME_FORMAT : String = "dd-MMM-yyyy HH:mm:ss"
    }
    
    
    enum AccessibilityIdentifier: String {
        case webView = "webViewIdentifier"
        case dateLabel = "dateIdentifier"
    }
}



