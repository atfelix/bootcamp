//
//  GameModel.m
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "GameModel.h"

#import "Player.h"
#import "Question.h"

#define NUM_PLAYERS 2
#define LOWER_BOUND 1
#define UPPER_BOUND 20

uint32_t getRandomIntegerInRange(int lower_bound, int upper_bound) {
    if (upper_bound < lower_bound) {
        return getRandomIntegerInRange(upper_bound, lower_bound) + lower_bound;
    }

    return lower_bound + arc4random_uniform((uint32_t) (upper_bound - lower_bound));
}

@implementation GameModel

- (instancetype)init {

    self = [super init];
    if (self) {
        [self restart];
    }
    return self;
}

-(Question *)generateQuestion {
    return [[Question alloc] initWithLeftValue:getRandomIntegerInRange(LOWER_BOUND, UPPER_BOUND)
                                 andRightValue:getRandomIntegerInRange(LOWER_BOUND, UPPER_BOUND)];
}

-(Player *)getCurrentPlayer {
    return self.players[self.currentIndex];
}

-(BOOL)takeTurnWithAnswer:(NSUInteger)answer {

    BOOL correctAnswer = YES;

    if (answer != [self.currentQuestion getAnswer]) {
        [[self getCurrentPlayer] loseLife];
        correctAnswer = NO;

        if ([self getCurrentPlayer].numLives == 0) {
            self.gameOver = YES;
        }
    }
    self.currentIndex = (self.currentIndex + 1) % self.players.count;
    self.currentQuestion = [self generateQuestion];

    return correctAnswer;
}

-(NSArray<NSNumber *> *)getGameState {
    NSMutableArray<NSNumber *> *scores = [[NSMutableArray alloc] init];
    for (Player *player in self.players) {
        [scores addObject:@(player.numLives)];
    }

    return scores;
}

-(void)restart {
    _currentIndex = 0;
    _gameOver = NO;
    _players = @[
                     [[Player alloc] init],
                     [[Player alloc] init]
                ];
    _currentQuestion = [self generateQuestion];
}

@end
