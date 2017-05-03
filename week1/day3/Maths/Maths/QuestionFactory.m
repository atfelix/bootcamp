//
//  QuestionFactory.m
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "QuestionFactory.h"

@implementation QuestionFactory

- (instancetype)init {

    self = [super init];
    if (self) {
        questionSubclassNames = @[@"AdditionQuestion",
                                  @"SubtractionQuestion",
                                  @"MultiplicationQuestion",
                                  @"DivisionQuestion"];
    }
    return self;
}

-(Question *)generateRandomQuestion {
    int randomIndex = arc4random_uniform(4);
    return [[NSClassFromString(questionSubclassNames[randomIndex]) alloc] init];
}

@end
