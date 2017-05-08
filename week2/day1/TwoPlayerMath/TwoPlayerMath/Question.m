//
//  Question.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Question.h"

@implementation Question

-(instancetype)initWithLeftValue:(NSUInteger)leftValue andRightValue:(NSUInteger)rightValue {

    self = [super init];
    if (self) {
        _leftValue = leftValue;
        _rightValue = rightValue;
    }
    return self;
}

-(NSUInteger)getAnswer {
    return self.leftValue + self.rightValue;
}

@end
