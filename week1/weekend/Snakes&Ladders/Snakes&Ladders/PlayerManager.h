//
//  PlayerManager.h
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Player.h"

@interface PlayerManager : NSObject

@property (nonatomic) NSMutableArray<Player *> *players;
@property (nonatomic) NSDictionary<NSNumber *, NSNumber *> *gameBoard;
@property (nonatomic, assign) BOOL gameOver;
@property (nonatomic, assign) NSUInteger currentIndex;

-(void) createPlayers:(NSUInteger) numPlayers;
-(void) roll;
-(void) output;

+(NSUInteger) getNumberOfPlayers;

@end
