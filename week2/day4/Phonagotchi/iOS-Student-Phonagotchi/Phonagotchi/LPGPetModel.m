//
//  LPGPetModel.m
//  Phonagotchi
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPetModel.h"

#define HappinessThreshold 52500
#define InitialRestfulness 10
#define SleepingRegenerationRate 3

static NSString *SleepingImageNameString = @"sleeping.png";
static NSString *GrumpyImageNameString = @"grumpy.png";
static NSString *AppleImageNameString = @"apple.png";
static NSString *BucketImageNameString = @"bucket.png";
static NSString *DefaultImageNameString = @"default.png";


@interface LPGPetModel ()

@property (nonatomic, assign, readwrite, getter=isHappy) BOOL happy;

@end

@implementation LPGPetModel

- (instancetype)init {

    self = [super init];
    if (self) {
        _happy = YES;
        _restfulness = InitialRestfulness;
        _sleeping = NO;
        _regenerationRate = SleepingRegenerationRate;
        _defaultImage = [UIImage imageNamed:DefaultImageNameString];
        _grumpyImage = [UIImage imageNamed:GrumpyImageNameString];
        _sleepingImage = [UIImage imageNamed:SleepingImageNameString];
        _appleImage = [UIImage imageNamed:AppleImageNameString];
        _bucketImage = [UIImage imageNamed:BucketImageNameString];
        _currentImage = _defaultImage;
    }
    return self;
}

-(void)rubPetWithVelocity:(CGPoint)velocity {
    self.happy = (velocity.x * velocity.x + velocity.y * velocity.y < [self getAlertness] * HappinessThreshold) ? YES : NO;
}

-(void)setRestfulness:(int)restfulness {
    NSLog(@"%@ __ %@", @(_restfulness), @(restfulness));
    if (restfulness == -1 && _restfulness == 0) {
        self.currentImage = self.grumpyImage;
    }
    if (restfulness < 0) {
        _restfulness = 0;
    }
    else if (restfulness > InitialRestfulness) {
        _restfulness = InitialRestfulness;
    }
    else {
        _restfulness = restfulness;
    }

    [self.delegate loadImageWithNewRestfulness:restfulness];
}

-(UIImage *)currentImage {
    
    if (self.isSleeping) {
        return self.sleepingImage;
    }
    else if (self.isHappy) {
        return self.defaultImage;
    }
    else {
        return self.grumpyImage;
    }
}

-(float)getAlertness {
    return (float) self.restfulness / InitialRestfulness;
}

-(BOOL)isFullyRested {
    self.restfulness = MIN(self.restfulness, InitialRestfulness);
    return self.restfulness == InitialRestfulness;
}

-(BOOL)isFullyDepleted {
    return self.restfulness == 0;
}

@end
