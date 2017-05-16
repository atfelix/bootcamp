//
//  Movie.m
//  W3D2-TableViews
//
//  Created by Kareem Sabri on 2017-05-16.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString*)title andGenre:(NSString*)genre andImage: (UIImage*)image
{
    self = [super init];
    if (self) {
        _title = title;
        _genre = genre;
        _image = image;
        _seenIt = false;
    }
    return self;
}

@end
