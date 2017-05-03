//
//  GameController.h
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Die;

@interface GameController : NSObject

@property (nonatomic) NSMutableArray<Die *> *dice;
@property (nonatomic) NSMutableSet<Die *> *heldDice;

-(void) toggleDie:(int) index;
-(void) rollDice;

@end
