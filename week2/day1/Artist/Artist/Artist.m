//
//  Artist.m
//  Artist
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Artist.h"

@implementation Artist

-(instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName {

    self = [super init];
    if (self) {
        _name = name;
        _photo = [UIImage imageNamed:imageName];
    }
    return self;
}

@end
