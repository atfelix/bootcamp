//
//  Player.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Player.h"

#define NUM_LIVES 3

@implementation Player

- (instancetype)init {

    self = [super init];
    if (self) {
        _numLives = NUM_LIVES;
    }
    return self;
}

-(void)loseLife {
    self.numLives--;
}

@end
