//
//  QuestionManager.m
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "QuestionManager.h"
#import "Question.h"

@implementation QuestionManager

- (instancetype)init {

    self = [super init];
    if (self) {
        _questions = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addQuestion:(Question *)question {
    [self.questions addObject:question];
}

-(NSString *)timeOutput {
    NSTimeInterval totalTime = 0.0;

    for (Question *question in self.questions) {
        totalTime += [question timeToAnswer];
    }

    NSTimeInterval averageTime = totalTime / self.questions.count;
    NSString *outputString = [NSString stringWithFormat:@"total time: %.0fs, average time: %.0fs", totalTime, averageTime];

    return outputString;
}

@end
