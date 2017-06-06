//
//  NewsItem.swift
//  StretchMyHeader
//
//  Created by atfelix on 2017-06-06.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

enum Category: String {
    case world = "World"
    case americas = "Americas"
    case europe = "Europe"
    case middleEast = "Middle East"
    case africa = "Africa"
    case asiaPacific = "Asia Pacific"
}

struct NewsItem {
    let category: Category
    var color: UIColor {
        switch category {
            case .world:         return UIColor.red
            case .americas:      return UIColor.blue
            case .europe:        return UIColor.green
            case .middleEast:    return UIColor.yellow
            case .africa:        return UIColor.orange
            case .asiaPacific:   return UIColor.purple
        }
    }
    var headline: String

    init(category: Category, headline: String?) {
        self.category = category
        self.headline = headline ?? ""
    }
}
