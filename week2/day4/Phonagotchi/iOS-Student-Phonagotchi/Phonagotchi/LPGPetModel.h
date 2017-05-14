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
@property (nonatomic, assign) int restfulness;

-(void)rubPetWithVelocity:(CGPoint) velocity;
-(float)getAlertness;

@end
