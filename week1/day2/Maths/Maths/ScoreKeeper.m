//
//  ScoreKeeper.m
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ScoreKeeper.h"

@implementation ScoreKeeper

- (instancetype)init {

    self = [super init];
    if (self) {
        _numQuestions = 0;
        _numCorrectAnswers = 0;
    }
    return self;
}

-(float)getPercentageCorrect {
    if (self.numQuestions == 0) {
        NSLog(@"No questions asked so far");
        NSLog(@"RETURNED: -INFINITY");
        return -INFINITY;
    }
    return (float) self.numCorrectAnswers / self.numQuestions * 100;
}

@end
