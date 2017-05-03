//
//  Dice.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Die.h"

#define NUM_DICE 6

@implementation Die

-(void)rollDie {
    self.dieValue = arc4random_uniform(6) + 1;
}

+(NSString *)dieCharacterWithValue:(int)value {

    if (value > NUM_DICE || value <= 0) {
        NSLog(@"Parameter |value| is not valid");
        return nil;
    }

    NSArray *diceStrings = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
    return diceStrings[value - 1];
}

-(NSString *)description {
    return [Die dieCharacterWithValue:(int)self.dieValue];
}

@end
