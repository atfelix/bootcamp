//
//  FlickrAPI.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "FlickrAPI.h"

#import "FLICKR_API_KEYS.h"
#import "FlickrPhoto.h"

@implementation FlickrAPI

+(void)searchFor:(NSString *)query completionHandler:(void(^)(NSArray *))complete {

    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *methodString = @"?method=flickr.photos.search";
    NSString *formatString = @"&format=json";
    NSString *hasGeoString = @"&has_geo=1";
    NSString *extrasString = @"";
    NSString *nocallbackString = @"&nojsoncallback=1";
    NSString *apiKeyString = [NSString stringWithFormat:@"&api_key=%@", API_KEY];
    NSString *tagString = [NSString stringWithFormat:@"&tags=%@", query];

    NSString *queryURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",
                                baseURLString,
                                methodString,
                                formatString,
                                nocallbackString,
                                apiKeyString,
                                tagString,
                                hasGeoString,
                                extrasString];

    NSURL *queryURL = [NSURL URLWithString:queryURLString];
    NSLog(@"%@", queryURLString);

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }

                                                             NSError *jsonError = nil;
                                                             NSDictionary *queryResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                          options:0
                                                                                                                            error:&jsonError];

                                                             if (jsonError) {
                                                                 NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                                                 return;
                                                             }

                                                             NSMutableArray *photosFound = [[NSMutableArray alloc] init];

                                                             for (NSDictionary *photoInfo in queryResults[@"photos"][@"photo"]) {
                                                                 [photosFound addObject:[[FlickrPhoto alloc] initWithInfo:photoInfo]];
                                                             }
                                                             complete(photosFound);
                                                         }
                              ];
   [task resume];
}

+(void)loadImage:(FlickrPhoto *)photo completionHandler:(void(^)(UIImage *))complete {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:photo.url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }
                                                             
                                                             complete([UIImage imageWithData:data]);
                                                         }];
    [task resume];
}

+(void)getInfoForPhoto:(FlickrPhoto *)photo completionHandler:(void(^)(NSArray *, NSURL *))complete{
    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *methodString = @"?method=flickr.photos.getInfo";
    NSString *formatString = @"&format=json";
    NSString *nocallbackString = @"&nojsoncallback=1";
    NSString *apiKeyString = [NSString stringWithFormat:@"&api_key=%@", API_KEY];
    NSString *secretString = [NSString stringWithFormat:@"&secret=%@", photo.secret];
    NSString *photoIdString = [NSString stringWithFormat:@"&photo_id=%@", photo.photoId];

    NSString *queryURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                                baseURLString,
                                methodString,
                                formatString,
                                nocallbackString,
                                apiKeyString,
                                secretString,
                                photoIdString];

    NSURL *queryURL = [NSURL URLWithString:queryURLString];
  
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }

                                                             NSError *jsonError = nil;
                                                             NSDictionary *queryResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                          options:0
                                                                                                                            error:&jsonError];

                                                             if (jsonError) {
                                                                 NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                                                 return;
                                                             }

                                                             NSMutableArray *tagsFound = [[NSMutableArray alloc] init];

                                                             for (NSDictionary *tagInfo in queryResults[@"photo"][@"tags"][@"tag"]) {
                                                                 [tagsFound addObject:tagInfo[@"raw"]];
                                                             }
                                                             complete(tagsFound, [NSURL URLWithString:queryResults[@"photo"][@"urls"][@"url"][0][@"_content"]]);
                                                         }
                              ];
    [task resume];
}


+(void)getGeoLocationForPhoto:(FlickrPhoto *)photo completionHandler:(void(^)(CLLocation *))complete {
    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *methodString = @"?method=flickr.photos.geo.getLocation";
    NSString *formatString = @"&format=json";
    NSString *nocallbackString = @"&nojsoncallback=1";
    NSString *apiKeyString = [NSString stringWithFormat:@"&api_key=%@", API_KEY];
    NSString *photoIdString = [NSString stringWithFormat:@"&photo_id=%@", photo.photoId];

    NSString *queryURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                                baseURLString,
                                methodString,
                                formatString,
                                nocallbackString,
                                apiKeyString,
                                photoIdString];

    NSURL *queryURL = [NSURL URLWithString:queryURLString];
    NSLog(@"%@", queryURLString);
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }

                                                             NSError *jsonError = nil;
                                                             NSDictionary *queryResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                          options:0
                                                                                                                            error:&jsonError];

                                                             if (jsonError) {
                                                                 NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                                                 return;
                                                             }

                                                             CLLocation *location = [[CLLocation alloc] initWithLatitude:[queryResults[@"photo"][@"location"][@"latitude"] doubleValue]
                                                                                                               longitude:[queryResults[@"photo"][@"location"][@"longitude"] doubleValue]];
                                                             complete(location);
                                                         }];
    [task resume];
}

+(void)getPhotosForGeoLocation:(CLLocation *)location completionHandler:(void (^)(NSArray *))complete {
    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *methodString = @"?method=flickr.photos.search";
    NSString *formatString = @"&format=json";
    NSString *hasGeoString = @"&has_geo=1";
    NSString *extrasString = @"";
    NSString *nocallbackString = @"&nojsoncallback=1";
    NSString *apiKeyString = [NSString stringWithFormat:@"&api_key=%@", API_KEY];
    NSString *latitudeString = [NSString stringWithFormat:@"lat=%@", @(location.coordinate.latitude)];
    NSString *longitudeString = [NSString stringWithFormat:@"lon=%@", @(location.coordinate.longitude)];

    NSString *queryURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",
                                baseURLString,
                                methodString,
                                formatString,
                                nocallbackString,
                                apiKeyString,
                                hasGeoString,
                                extrasString,
                                latitudeString,
                                longitudeString];

    NSURL *queryURL = [NSURL URLWithString:queryURLString];
    NSLog(@"%@", queryURLString);

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }

                                                             NSError *jsonError = nil;
                                                             NSDictionary *queryResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                          options:0
                                                                                                                            error:&jsonError];

                                                             if (jsonError) {
                                                                 NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                                                 return;
                                                             }

                                                             NSMutableArray *photosFound = [[NSMutableArray alloc] init];

                                                             for (NSDictionary *photoInfo in queryResults[@"photos"][@"photo"]) {
                                                                 [photosFound addObject:[[FlickrPhoto alloc] initWithInfo:photoInfo]];
                                                             }
                                                             complete(photosFound);
                                                         }
                              ];
    [task resume];
}

@end
