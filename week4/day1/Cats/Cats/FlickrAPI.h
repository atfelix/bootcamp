//
//  FlickrAPI.h
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface FlickrAPI : NSObject

+(void)searchFor:(NSString *)query completionHandler:(void(^)(NSArray *searchResults))complete;
+(void)loadImage:(UIImage *)image completionHandler:(void(^)(UIImage *))complete;

@end
