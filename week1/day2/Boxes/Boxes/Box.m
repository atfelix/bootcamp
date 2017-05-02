//
//  Box.m
//  Boxes
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Box.h"

int float_cmp (const void *a, const void *b) {
    float *A = (float *) a;
    float *B = (float *) b;

    if (*A < *B) {
        return -1;
    }
    else if (*B < *A) {
        return +1;
    }
    else {
        return 0;
    }
}

@implementation Box

-(instancetype)initWithHeight:(float)height Width:(float)width andLength:(float)length {

    if ((height <= 0) || (width <= 0) || (length <= 0)) {
        NSLog(@"All parameters must be positive.");
        NSLog(@"Initialization failed.");
        NSLog(@"RETURNED: nil");
        return nil;
    }

    if (self = [super init]) {
        _height = height;
        _width = width;
        _length = length;
    }
    return self;
}

-(float)getVolume {
    return self.height * self.width * self.length;
}

-(int)numberBoxesWhichFitinOtherBox:(Box *)otherBox {
    return (int) ([otherBox getVolume] / [self getVolume]);
}

@end
