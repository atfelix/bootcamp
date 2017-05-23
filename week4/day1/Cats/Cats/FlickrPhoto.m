//
//  FlickrPhoto.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "FlickrPhoto.h"

#import "FlickrAPI.h"

@interface FlickrPhoto ()

@end

@implementation FlickrPhoto

-(instancetype)initWithInfo:(NSDictionary *)info {
    self = [super init];
    if (self) {
        _photoId = info[@"id"];
        _farm = info[@"farm"];
        _server = info[@"server"];
        _secret = info[@"secret"];
        _title = info[@"title"];
    }
    return self;
}

-(NSString *)description {
    NSMutableString *desc = [@"FlickrPhoto\n" mutableCopy];
    [desc appendFormat:@"\t\tid:     %@\n", self.photoId];
    [desc appendFormat:@"\t\ttitle:  %@\n", self.title];
    [desc appendFormat:@"\t\tfarm:   %@\n", self.farm];
    [desc appendFormat:@"\t\tserver: %@\n", self.server];
    [desc appendFormat:@"\t\tsecret: %@\n", self.secret];

    return desc;
}

-(NSURL *)url {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                                 self.farm,
                                 self.server,
                                 self.photoId,
                                 self.secret]];
}

-(UIImage *)image {
    if (!_image) {
        [FlickrAPI loadImage:self
           completionHandler:^(UIImage *image) {
               _image = image;
           }];
    }
    return _image;
}

@end
