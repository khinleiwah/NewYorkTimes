//
//  APIManager.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

typealias completionBlock = ([Article]?,Error?) -> ()

class APIManager: NSObject {
    static let shared = APIManager()
    let session = URLSession.shared
    
    func searchArticle(keyword:String,pageIndex:String, completion: @escaping completionBlock) {
        
        let urlString = String.init(format: Constants.searchUrl, keyword,pageIndex)
        session.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil,error)
            }

            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let json = try? decoder.decode(ResponseJson.self, from: data) else {
                print("cannot decode")
           
                let alert = UIAlertController.init(title: "Alert", message: "Please retry the loading", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                    completion(nil,error)
                }))
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController!.present(alert, animated: true, completion: nil)
                return
            }

            if let articles = (json.response as Response).docs {
                completion(articles,nil)
            }

        }.resume()
    }
}

