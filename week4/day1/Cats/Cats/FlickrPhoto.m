//
//  FlickrPhoto.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "FlickrPhoto.h"

@interface FlickrPhoto ()

@property (nonatomic) NSString *photoId;
@property (nonatomic) NSString *farm;
@property (nonatomic) NSString *server;
@property (nonatomic) NSString *secret;

@end

@implementation FlickrPhoto

-(instancetype)initWithInfo:(NSDictionary *)info {
    self = [super init];
    if (self) {
        _photoId = info[@"id"];
        _farm = info[@"farm"];
        _server = info[@"server"];
        _secret = info[@"secret"];
    }
    return self;
}

-(NSString *)description {
    NSMutableString *desc = [@"FlickrPhoto\n" mutableCopy];
    [desc appendFormat:@"\t\tid:     %@\n", self.photoId];
    [desc appendFormat:@"\t\tfarm:   %@\n", self.farm];
    [desc appendFormat:@"\t\tserver: %@\n", self.server];
    [desc appendFormat:@"\t\tsecret: %@\n", self.secret];

    return desc;
}

@end
