//
//  LPGPetModel.m
//  Phonagotchi
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPetModel.h"

#define HappinessThreshold 52500
#define InitialRestfulness 180

@interface LPGPetModel ()

@property (nonatomic, assign, readwrite, getter=isHappy) BOOL happy;

@end

@implementation LPGPetModel

- (instancetype)init {

    self = [super init];
    if (self) {
        _happy = YES;
        _restfulness = InitialRestfulness;
    }
    return self;
}

-(void)rubPetWithVelocity:(CGPoint)velocity {
    self.happy = (velocity.x * velocity.x + velocity.y * velocity.y < [self getAlertness] * HappinessThreshold) ? YES : NO;
}

-(float)getAlertness {
    return (float) self.restfulness / InitialRestfulness;
}

@end
