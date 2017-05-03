//
//  MultiplicationQuestion.m
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "MultiplicationQuestion.h"

@implementation MultiplicationQuestion

-(void)generateQuestion {
    self.answer = self.leftValue * self.rightValue;
    self.question = [NSString stringWithFormat:@"What is %li %@ %li?", self.leftValue, @"*", self.rightValue];
}

@end
