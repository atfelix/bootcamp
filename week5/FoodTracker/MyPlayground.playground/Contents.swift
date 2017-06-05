//: Playground - noun: a place where people can play

import UIKit

let urlBase = URL(string: "http://159.203.243.24:8000/signup")!
var request = URLRequest(url: urlBase)
request.httpMethod = "POST"

let json: [String:Any] = ["username":"furious_potato_cake", "password":"1234"]
let jsonData = try? JSONSerialization.data(withJSONObject: json, options:[])
request.httpBody = jsonData



var response: [String: Any]

let task = URLSession.shared.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
    if error != nil {
        print("error \(error)")
    }
    else if data != nil {
        if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
            print("received data: \(str)")
        }
        else {
            print("unable to convert")
        }
    }
})

task.resume()