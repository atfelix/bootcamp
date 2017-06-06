//
//  APIManager.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    class func signupUser(username: String, password: String) {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "username", value: username))
        queryItems.append(URLQueryItem(name: "password", value: password))
        let urlPath = APIManager.urlFromData(path: "/signup", queryItems: queryItems)

        var request = URLRequest(url: urlPath!)

        let json: [String:Any] = ["username": username, "password":password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])

        request.httpMethod = "POST"
        request.httpBody = jsonData

        print(request.url!)
        print(request.httpMethod!)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "NO DATA")
                return
            }
            print("STUFF")

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

            print("OTHER STUFF")

            if let responseJSON = responseJSON as? [String:Any] {
                print(responseJSON)
            }
        })

        task.resume()
    }

    class func loginUser(username: String, password: String) {
        
    }

    private class func urlFromData(path: String, queryItems: [URLQueryItem]?, scheme: String = "http", host: String = "159.203.243.24", port: Int = 8000) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems ?? []
        return components.url
    }

}
