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

+(void)searchFor:(NSString *)query completionHandler:(void (^)(NSArray *))complete {
    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *methodString = @"?method=flickr.photos.search";
    NSString *formatString = @"&format=json";
    NSString *nocallbackString = @"&nojsoncallback=1";
    NSString *apiKeyString = [NSString stringWithFormat:@"&api_key=%@", API_KEY];
    NSString *tagString = [NSString stringWithFormat:@"&tags=%@", query];

    NSString *queryURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                                baseURLString,
                                methodString,
                                formatString,
                                nocallbackString,
                                apiKeyString,
                                tagString];

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

                                                             NSMutableArray *photosFound = [[NSMutableArray alloc] init];

                                                             for (NSDictionary *photoInfo in queryResults[@"photos"][@"photo"]) {
                                                                 [photosFound addObject:[[FlickrPhoto alloc] initWithInfo:photoInfo]];
                                                             }
                                                             complete(photosFound);
                                                         }
                              ];
   [task resume];
}

+(void)loadImage:(FlickrPhoto *)photo completionHandler:(void (^)(UIImage *))complete {
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:photo.url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             if (error) {
                                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                                 return;
                                                             }
                                                             NSLog(@"Done");
                                                             complete([UIImage imageWithData:data]);
                                                         }];
    [task resume];
}

@end
