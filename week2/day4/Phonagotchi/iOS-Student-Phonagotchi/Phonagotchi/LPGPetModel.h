//
//  LPGPetModel.h
//  Phonagotchi
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPGPetModel : NSObject

@property (nonatomic, assign, readonly, getter=isHappy) BOOL happy;
@property (nonatomic, assign, getter=isSleeping) BOOL sleeping;
@property (nonatomic, assign) int restfulness;
@property (nonatomic, assign, readonly) int regenerationRate;


-(void)rubPetWithVelocity:(CGPoint) velocity;
-(float)getAlertness;
-(BOOL)isFullyRested;
-(BOOL)isFullyDepleted;

@end
