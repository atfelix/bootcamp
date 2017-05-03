//
//  Dice.h
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUM_DICE 5

@interface Die : NSObject

@property (nonatomic) NSUInteger dieValue;

-(void) rollDie;

+(NSString *) dieCharacterWithValue: (int) value;

@end
