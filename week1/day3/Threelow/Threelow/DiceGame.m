//
//  DiceGame.m
//  Threelow
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DiceGame.h"
#import "Die.h"
#import "InputCollector.h"

#define NUM_DICE 5

@implementation DiceGame

- (instancetype)init {

    self = [super init];
    if (self) {
        _dice = [[NSMutableArray alloc] init];
        _numRollsSinceLastReset = 0;
        _gameOn = YES;
        _inputCollector = [[InputCollector alloc] init];

        for (int i = 0; i < NUM_DICE; i++) {
            Die *die = [[Die alloc] init];
            [die rollDie];
            [_dice addObject:die];
        }
    }
    return self;
}

-(void)playGame {
    while (self.gameOn) {
        [self takeTurn];
    }
}

-(void) takeTurn {

    NSUInteger oldValues[NUM_DICE];

    for (int i = 0; i < NUM_DICE; i++) {
        oldValues[i] = self.dice[i].dieValue;
    }

    NSString *promptString = [NSString stringWithFormat:@"\n\nWould you like to toggle any die (1-%d or quit)?", NUM_DICE];

    NSLog(@"%@", promptString);

    while (1) {

        NSString *userInput = [self.inputCollector inputFromPrompt:@""];

        if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
            for (int i = 0; i < NUM_DICE; i++) {
                if (self.dice[i].dieValue != oldValues[i]) {
                    return;
                }
            }

            NSLog(@"Nice Try.  You have to grab a dice.");
            continue;
        }

        else if (![InputCollector isValidEmail:userInput]) {
            NSLog(@"Invalid input.  Please input number between 1 and %d", NUM_DICE);
            continue;
        }

        [self holdDie:[userInput intValue] - 1];
    }
}

-(void) holdDie:(int) index {
    if (index < 0 || index >= self.dice.count) {
        NSLog(@"Invalid index.  Please try again");
        return;
    }
    

@end
