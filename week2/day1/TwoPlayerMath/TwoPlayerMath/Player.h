//
//  Player.h
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, assign) NSInteger numLives;

-(void) loseLife;

@end
