//
//  LPGPetModel.h
//  Phonagotchi
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PetDelegate <NSObject>

-(void)loadImageWithNewRestfulness:(int)restfulness;

@end

@interface LPGPetModel : NSObject

@property (nonatomic, assign, readwrite, getter=isHappy) BOOL happy;
@property (nonatomic, assign, getter=isSleeping) BOOL sleeping;
@property (nonatomic, assign) int restfulness;
@property (nonatomic, assign, readonly) int regenerationRate;

@property (nonatomic) UIImage *appleImage;
@property (nonatomic) UIImage *bucketImage;

@property (nonatomic) UIImage *sleepingImage;
@property (nonatomic) UIImage *defaultImage;
@property (nonatomic) UIImage *grumpyImage;


@property (nonatomic) UIImage *currentImage;

@property (nonatomic, weak) id<PetDelegate> delegate;

-(void)rubPetWithVelocity:(CGPoint) velocity;
-(float)getAlertness;
-(BOOL)isFullyRested;
-(BOOL)isFullyDepleted;

@end
