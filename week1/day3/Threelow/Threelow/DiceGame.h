//
//  DiceGame.h
//  Threelow
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Game.h"

@class Die;
@class InputCollector;

@interface DiceGame : NSObject <Game>

@property (nonatomic) NSMutableArray<Die *> *dice;
@property (nonatomic) NSUInteger numRollsSinceLastReset;
@property (assign, nonatomic) BOOL gameOn;
@property (nonatomic) InputCollector *inputCollector;

@end
