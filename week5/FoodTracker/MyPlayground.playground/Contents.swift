//: Playground - noun: a place where people can play

import UIKit

var components = URLComponents()
components.scheme = "https"
components.host = "159.203.243.24"
components.port = 8000
components.path = "/signup"

let queryItemUsername = URLQueryItem(name: "username", value: "old_banana_bread_sucks")
let queryItemPassword = URLQueryItem(name: "password", value: "1234")

components.queryItems = [queryItemUsername, queryItemPassword]

components.url