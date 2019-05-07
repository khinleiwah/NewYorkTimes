//
//  APIObjects.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class APIObjects: NSObject {
    
}

struct ResponseJson: Codable {
    let status: String
    let copyright: String
    let response: Response
}

struct Response: Codable {
    struct Meta:Codable {
        let hits: Int?
        let offset: Int?
        let time: Int?
    }
    let docs:[Article]?
    let meta: Response.Meta?
}

struct Legacy: Codable {
    var xlargewidth: Int?
    var xlargeheight: Int?
    var xlarge: String?
}

struct Multimedia: Codable {
    var rank: Int
    var subtype: String?
    var caption: String?
    var credit: String?
    var type: String?
    var url: String
    var height: Int?
    var width: Int?
    var legacy: Legacy?
    var subType: String?
    var crop_name: String?
    
}

struct Keywords: Codable {
    var name: String
    var value: String
    var rank: Int?
    var major: String?
}

struct Headline: Codable {
    var content_kicker: String?
    var kicker: String?
    var main: String?
    var name:String?
    var print_headline: String?
    var seo:String?
    var sub:String?
}

struct Byline: Codable {
    var original:String?
    var person:[Person]?
    var organization: String?
}

struct Person: Codable {
    var firstname: String?
    var middlename: String?
    var lastname: String?
    var qualifier: String?
    var title: String?
    var role: String?
    var organization: String?
    var rank: Int?
}

struct Article {
    var web_url: String
    var _id: String
    var byline:  Byline?
    var document_type: String?
    var headline: Headline?
    var keywords: [Keywords]?
    var multimedia: [Multimedia]?
    var news_desk: String?
    var print_page: Int?
    var pub_date: String?
    var score: Int?
    var snippet: String?
    var source: String?
    
    var type_of_material: String?
    var uri: String?
    var word_count: Int?
    
    enum CodingKeys: String, CodingKey {
        case web_url = "webUrl"
        case _id
        case byline
        case document_type
        case headline
        case keywords
        case multimedia
        case news_desk
        case print_page
        case pub_date = "pubDate"
        
        case score
        case snippet
        case source
        
        case type_of_material
        case uri
        
        case word_count
    }
}

extension Article: Encodable {
    func encode(to encoder: Encoder) throws {
        
    }
}

extension Article: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        web_url = try values.decodeIfPresent(String.self, forKey: .web_url)!
        print("web url \(String(describing: web_url))")
        _id = try values.decodeIfPresent(String.self, forKey: ._id)!
        byline = try values.decodeIfPresent(Byline.self, forKey: .byline)
        document_type = try values.decodeIfPresent(String.self, forKey: .document_type)
        headline = try values.decodeIfPresent(Headline.self, forKey: .headline)
        
        keywords = try values.decodeIfPresent([Keywords].self, forKey: .keywords)
        multimedia = try values.decodeIfPresent([Multimedia].self, forKey: .multimedia)
        
        
        news_desk = try values.decodeIfPresent(String.self, forKey: .news_desk)
        print_page = try values.decodeIfPresent(Int.self, forKey: .print_page)
        pub_date = try values.decodeIfPresent(String.self, forKey: .pub_date)
        
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        snippet = try values.decode(String.self, forKey: .snippet)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        
        type_of_material = try values.decodeIfPresent(String.self, forKey: .type_of_material)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
       
        word_count = try values.decodeIfPresent(Int.self, forKey: .word_count)
    }
}
