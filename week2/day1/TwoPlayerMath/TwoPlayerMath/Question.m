//
//  Question.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Question.h"

@implementation Question

-(instancetype)init {

    self = [super init];
    if (self) {
        _leftValue = arc4random_uniform(20) + 1;
        _rightValue = arc4random_uniform(20) + 1;
        _answer = -INFINITY;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%lu %c %lu?", self.leftValue, self.operatorChar, self.rightValue];
}

@end
