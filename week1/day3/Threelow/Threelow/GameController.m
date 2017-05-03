//
//  GameController.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "GameController.h"
#import "Die.h"

#define NUM_CHARS 255
#define NUM_DICE 6

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

        NSLog(@"%lu", self.dice.count);
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

    for (Die *die in self.dice) {
        if ([self.heldDice containsObject:die]) {
            [output appendFormat:@" <%@> ", die];
        }
        else {
            [output appendFormat:@" %@ ", die];
        }
    }
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

@end
