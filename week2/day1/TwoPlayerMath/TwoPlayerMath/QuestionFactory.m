//
//  QuestionFactory.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-09.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "QuestionFactory.h"

#import "Question.h"
#import "AdditionQuestion.h"
#import "SubtractionQuestion.h"
#import "MultiplicationQuestion.h"
#import "DivisionQuestion.h"

@interface QuestionFactory ()

@property (nonatomic) NSArray<NSString *> *questionSubclassNames;

@end

@implementation QuestionFactory

+(Question *)generateQuestion {
    NSArray<NSString *> *questionSubclassNames = @[@"AdditionQuestion",
                                                   @"SubtractionQuestion",
                                                   @"MultiplicationQuestion",
                                                   @"DivisionQuestion"];
    int randomIndex = arc4random_uniform(4);
    return [[NSClassFromString(questionSubclassNames[randomIndex]) alloc] init];
}


@end
