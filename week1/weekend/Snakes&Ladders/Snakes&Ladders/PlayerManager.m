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
        _gameBoard = @{
                       @(4):@(14),  @(9):@(31),  @(17):@(7),  @(20):@(38),
                       @(28):@(84), @(40):@(59), @(51):@(67), @(63):@(81),
                       @(64):@(60), @(89):@(26), @(95):@(75), @(99):@(78)
                      };
    }
    return self;
}

-(void)playGame {

    _gameOver = NO;

    [self createPlayers:[self getNumberOfPlayers]];

    NSLog(@"Please type \"roll\" or \"r\"");

    while (!self.gameOver) {

        NSString *userInput = [InputCollector getAndParseStringFromPromptString:@""];

        if (!userInput || userInput.length == 0) {
            continue;
        }
        else if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
            [self quitOrRestart];
        }
        else if ([userInput caseInsensitiveCompare:@"roll"] == NSOrderedSame) {
            [self roll];
        }
        else if ([userInput caseInsensitiveCompare:@"r"] == NSOrderedSame) {
            [self roll];
        }
        else if ([userInput caseInsensitiveCompare:@"output"] == NSOrderedSame) {
            [self output];
        }
    }

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
        [self endGame];
        return;
    }
    NSLog(@"%@ landed on %ld", currentPlayer, currentPlayer.currentSquare);

    self.currentIndex++;
}

-(void) output {
    NSLog(@"%@", [self score]);
}

-(Player *) getCurrentPlayer {
    return self.players[self.currentIndex % self.players.count];
}

-(NSString *)score {
    NSMutableString *desc = [[NSMutableString alloc] init];

    [desc appendFormat:@"score: "];

    for (Player *player in self.players) {
        [desc appendFormat:@"%@'s %@, ", player.name, [player score]];
    }

    return desc;
}

-(void)endGame {
    self.gameOver = YES;
    [self.players removeAllObjects];
}

-(NSUInteger)getNumberOfPlayers {

    while (1) {
        NSString *numPlayersString = [InputCollector getAndParseStringFromPromptString:@"Enter the number of players:"];

        if ([numPlayersString caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
            [self quitOrRestart];
        }
        else if (![InputCollector isValidInteger:numPlayersString]) {
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

-(void)quitOrRestart {
    NSString *userInput = [InputCollector getAndParseStringFromPromptString:@"\n\n\tType one of the following:\n\n\tquit: quit the application\n\trestart: start a new game\n\nAny other response will be cancel the quit process"];

    if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
        NSLog(@"Thank you for playing");
        exit(EXIT_SUCCESS);
    }
    else if ([userInput caseInsensitiveCompare:@"restart"] == NSOrderedSame) {
        [self endGame];
        [self playGame];
    }
}


@end
