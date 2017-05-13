//
//  LineSegment.m
//  W2D5Lecture
//
//  Created by atfelix on 2017-05-12.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "LineSegment.h"

@implementation LineSegment

-(instancetype)initWithStart:(CGPoint)start andEnd:(CGPoint)end {

    self = [super init];
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}

- (instancetype)init {
    return [self initWithStart:CGPointMake(0, 0)
                        andEnd:CGPointMake(0, 0)];
}

@end
