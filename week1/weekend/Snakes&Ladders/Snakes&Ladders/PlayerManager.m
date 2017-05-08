//
//  PlayerManager.m
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PlayerManager.h"
#import "Player.h"
#import "InputCollector.h"

#define LOWER_BOUND 1
#define UPPER_BOUND 6
#define END_SQUARE 100

NSInteger getRandomIntegerInRange(NSInteger lower, NSInteger upper) {
    if (lower > upper) {
        return getRandomIntegerInRange(upper, lower);
    }
    return lower + arc4random_uniform((uint32_t)(upper - lower + 1));
}

@implementation PlayerManager

- (instancetype)init {

    self = [super init];
    if (self) {
        _players = [[NSMutableArray alloc] init];
        _currentIndex = 0;
        _gameOver = NO;
        _gameBoard = @{
                       @(4):@(14),  @(9):@(31),  @(17):@(7),  @(20):@(38),
                       @(28):@(84), @(40):@(59), @(51):@(67), @(63):@(81),
                       @(64):@(60), @(89):@(26), @(95):@(75), @(99):@(78)
                      };
    }
    return self;
}

-(void)createPlayers:(NSUInteger)numPlayers {
    for (int i = 0; i < numPlayers; i++) {
        [self.players addObject:[[Player alloc] initWithName:[NSString stringWithFormat:@"player%d", i + 1]]];
    }
}

-(void) roll {

    Player *currentPlayer = [self getCurrentPlayer];
    NSInteger randomValue = getRandomIntegerInRange(LOWER_BOUND, UPPER_BOUND);

    NSLog(@"%@ rolled a %ld", currentPlayer.name, randomValue);

    currentPlayer.currentSquare += randomValue;

    if (self.gameBoard[@(currentPlayer.currentSquare)]) {
        currentPlayer.currentSquare = [self.gameBoard[@(currentPlayer.currentSquare)] integerValue];
    }

    if (currentPlayer.currentSquare >= END_SQUARE) {
        NSLog(@"Game Over, %@ won!", currentPlayer);
        exit(EXIT_SUCCESS);
    }
    NSLog(@"%@ landed on %ld", currentPlayer, currentPlayer.currentSquare);

    self.currentIndex++;
}

-(void) output {
    for (Player *player in self.players) {
        NSLog(@"%@'s current square: %ld", player.name, player.currentSquare);
    }
}

-(Player *) getCurrentPlayer {
    return self.players[self.currentIndex % self.players.count];
}

+(NSUInteger)getNumberOfPlayers {

    while (1) {
        NSString *numPlayersString = [InputCollector getAndParseStringFromPromptString:@"Enter the number of players:"];

        if (![InputCollector isValidInteger:numPlayersString]) {
            NSLog(@"Input is not a valid integer");
            continue;
        }
        else if ([numPlayersString integerValue] <= 0) {
            NSLog(@"Input must be a positive integer");
            continue;
        }
        return [numPlayersString integerValue];
    }
    
}

@end
