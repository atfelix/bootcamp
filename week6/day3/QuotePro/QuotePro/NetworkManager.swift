//
//  NetworkManager.swift
//  QuotePro
//
//  Created by atfelix on 2017-06-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

final class NetworkManager {
    static func fetchImage(completion: @escaping (UIImage?) -> Void) {
        let components = URLComponents(string: "http://lorempixel.com/200/300")!
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            var image : UIImage?
            defer {
                completion(image)
            }

            if error != nil {
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            guard let data = data else {
                return
            }

            image = UIImage(data: data)
            }.resume()
    }

    static func fetchQuote(completion: @escaping (String?, String?) -> Void) {
        let components = URLComponents(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            var quoteText, authorText: String?

            defer {
                completion(quoteText, authorText)
            }

            if error != nil {
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

                guard let jsonDictionary = jsonObject as? [AnyHashable:Any] else {
                    return
                }

                quoteText = jsonDictionary["quoteText"] as! String?
                authorText = jsonDictionary["quoteAuthor"] as! String?
            }
            catch let jsonError {
                print("JSON Error: \(jsonError)")
            }
        }.resume()
    }
}
