//
//  GameController.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "GameController.h"
#import "InputCollector.h"
#import "Die.h"

@implementation GameController

- (instancetype)init {

    self = [super init];
    if (self) {
        _dice = [[NSMutableArray alloc] init];
        _heldDice = [[NSMutableSet alloc] init];
        _numRollsSinceLastReset = 0;
        _inputCollector = [[InputCollector alloc] init];

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

    [output appendString:@"\n\n========================================================\n"];

    for (Die *die in self.dice) {
        if ([self.heldDice containsObject:die]) {
            [output appendFormat:@" <%@> ", die];
        }
        else {
            [output appendFormat:@" %@ ", die];
        }
    }

    [output appendFormat:@"\nCurrent Score: %lu", [self getScore]];
    [output appendFormat:@"\nNumber of Rolls since last reset: %lu\n", self.numRollsSinceLastReset];
    [output appendString:@"========================================================\n\n"];
    return output;
}

-(void)rollDice {

    self.numRollsSinceLastReset++;

    for (Die *die in self.dice) {
        if (![self.heldDice containsObject:die]) {
            [die rollDie];
        }
    }
}

-(void) resetDice {
    self.numRollsSinceLastReset = 0;
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

-(NSString *)takeTurn {
    BOOL oldHeld[NUM_DICE];

    for (int i = 0; i < NUM_DICE; i++) {
        oldHeld[i] = [self.heldDice containsObject:self.dice[i]];
    }

    while (1) {
        NSString *promptString = [NSString stringWithFormat:@"\n\nWould you like to toggle any die (1-%d or quit)?", NUM_DICE];
        NSString *userInput = [self.inputCollector inputFromPrompt:promptString];

        if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {

            for (int i = 0; i < NUM_DICE; i++) {
                if (oldHeld[i] != [self.heldDice containsObject:self.dice[i]]) {
                    break;
                }
            }

            NSLog(@"Nice Try.  You have to change something.");
            continue;
        }

        if (![InputCollector isValidInteger:userInput]) {
            NSLog(@"Invalid input.  Please try again.");
            continue;
        }

        int index = [userInput intValue];

        if (index < 1 || index > NUM_DICE) {
            NSLog(@"Invalid index.  Please try again.");
            continue;
        }

        [self toggleDie:index - 1];
    }

    NSString *userInput = [self.inputCollector inputFromPrompt:@""];
    return userInput;
}

@end
