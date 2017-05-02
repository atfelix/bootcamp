//
//  AdditionQuestion.m
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "AdditionQuestion.h"

#define LOWER_BOUND 10
#define UPPER_BOUND 100

NSInteger getRandomNumber(NSUInteger lower_bound, NSUInteger upper_bound) {

    if (lower_bound > upper_bound) {
        return -1;
    }
    return lower_bound + arc4random_uniform((uint32_t)(upper_bound - lower_bound));
}


@implementation AdditionQuestion

- (instancetype)init {

    self = [super init];
    if (self) {
        NSUInteger a = getRandomNumber(LOWER_BOUND, UPPER_BOUND);
        NSUInteger b = getRandomNumber(LOWER_BOUND, UPPER_BOUND);
        _answer = a + b;
        _question = [NSString stringWithFormat:@"What is %lu + %lu?", a, b];
    }
    return self;
}

@end
