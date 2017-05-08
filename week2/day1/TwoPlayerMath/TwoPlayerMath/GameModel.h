//
//  GameModel.h
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class Question;

@interface GameModel : NSObject

@property (nonatomic) NSArray<Player *> *players;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic) Question *currentQuestion;
@property (nonatomic, assign) BOOL gameOver;

-(Player *) getCurrentPlayer;
-(BOOL) takeTurnWithAnswer:(NSUInteger) answer;
-(NSArray<NSNumber *> *) getGameState;
-(void) restart;

@end
