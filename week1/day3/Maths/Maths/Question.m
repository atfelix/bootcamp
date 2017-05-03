//
//  Question.m
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Question.h"

#define LOWER_BOUND 10
#define UPPER_BOUND 100

NSInteger getRandomNumber(NSUInteger lower_bound, NSUInteger upper_bound) {

    if (lower_bound > upper_bound) {
        return -1;
    }
    return lower_bound + arc4random_uniform((uint32_t)(upper_bound - lower_bound));
}


@implementation Question

- (instancetype)init {

    self = [super init];
    if (self) {
        _leftValue = getRandomNumber(LOWER_BOUND, UPPER_BOUND);
        _rightValue = getRandomNumber(LOWER_BOUND, UPPER_BOUND);
        _startTime = [NSDate date];
        [self generateQuestion];
    }
    return self;
}

-(NSInteger)answer {
    _endTime = [NSDate date];
    return _answer;
}

-(NSTimeInterval)timeToAnswer {
    if (_endTime == nil) {
        NSLog(@"Answer hasn't been given");
        return (NSTimeInterval) -1.0;
    }

    return [self.endTime timeIntervalSinceDate:self.startTime];
}

-(void) generateQuestion {
}

@end
