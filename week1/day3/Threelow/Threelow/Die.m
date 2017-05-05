//
//  Dice.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Die.h"

#define NUM_SIDES 6

static NSArray *diceStrings;

@implementation Die

-(void)rollDie {
    self.dieValue = arc4random_uniform(NUM_SIDES) + 1;
}

+(NSString *)dieCharacterWithValue:(int)value {
    if (value > NUM_SIDES || value <= 0) {
        NSLog(@"Parameter |value| is not valid");
        printf("in die description\n");
        return nil;
    }

    return diceStrings[value - 1];
}

-(NSString *)description {
    return [Die dieCharacterWithValue:(int)self.dieValue];
}

+(void)initialize {
    diceStrings =  @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
}

@end
