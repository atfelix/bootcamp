//
//  GameController.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "GameController.h"
#import "Die.h"

@implementation GameController

- (instancetype)init {

    self = [super init];
    if (self) {
        _dice = [[NSMutableArray alloc] init];
        _heldDice = [[NSMutableSet alloc] init];

        for (int i = 0; i < NUM_DICE; i++) {
            Die *die = [[Die alloc] init];
            [die rollDie];
            [_dice addObject:die];
        }
    }
    return self;
}

-(void)toggleDie:(int) index{

    if (0 > index || self.dice.count <= index) {
        NSLog(@"gameController:toggleDie invalid index given");
        return;
    }

    Die *die = self.dice[index];

    if ([self.heldDice containsObject:die]) {
        [self.heldDice removeObject:die];
    }
    else {
        [self.heldDice addObject:die];
    }
}

-(NSString *)description {
    NSMutableString *output = [[NSMutableString alloc] init];

    [output appendString:@"\n\n============================\n"];

    for (Die *die in self.dice) {
        if ([self.heldDice containsObject:die]) {
            [output appendFormat:@" <%@> ", die];
        }
        else {
            [output appendFormat:@" %@ ", die];
        }
    }

    [output appendFormat:@"\nCurrent Score: %lu\n", [self getScore]];
    [output appendString:@"============================\n\n"];
    return output;
}

-(void)rollDice {
    for (Die *die in self.dice) {
        if (![self.heldDice containsObject:die]) {
            [die rollDie];
        }
    }
}

-(void) resetDice {
    [self.heldDice removeAllObjects];
}

-(NSUInteger)getScore {
    NSUInteger score = 0;

    for (Die *die in self.dice) {
        NSUInteger dieValue = die.dieValue;
        score += (dieValue == 3) ? 0 : dieValue;
    }

    return score;
}


@end
