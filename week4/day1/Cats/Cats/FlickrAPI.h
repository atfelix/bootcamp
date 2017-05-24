//
//  FlickrAPI.h
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@import MapKit;

@class FlickrPhoto;

@interface FlickrAPI : NSObject

+(void)searchFor:(NSString *)query completionHandler:(void(^)(NSArray *searchResults))complete;
+(void)loadImage:(FlickrPhoto *)photo completionHandler:(void(^)(UIImage *image))complete;
+(void)getInfoForPhoto:(FlickrPhoto *)photo completionHandler:(void (^)(NSArray *searchResults, NSURL *url))complete;
+(void)getGeoLocationForPhoto:(FlickrPhoto *)photo completionHandler:(void(^)(CLLocation *location))complete;
+(void)getPhotosForGeoLocation:(CLLocation *)location completionHandler:(void(^)(NSArray *searchResults))complete;
+(void)getGeoLocationsForPhotos:(NSArray *)photos completionHandler:(void(^)(NSArray *))complete;

@end
