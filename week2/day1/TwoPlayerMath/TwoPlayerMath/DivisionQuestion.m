//
//  DivisionQuestion.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-09.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DivisionQuestion.h"

@implementation DivisionQuestion

- (instancetype)init {

    self = [super init];
    if (self) {
        self.operatorChar = '/';
        self.answer = self.leftValue / self.rightValue;
    }
    return self;
}

@end
