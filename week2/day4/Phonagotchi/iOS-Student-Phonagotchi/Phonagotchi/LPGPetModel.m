//
//  LPGPetModel.m
//  Phonagotchi
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPetModel.h"


#pragma mark - Macros for pet initialization

#define HappinessThreshold 52500
#define InitialRestfulness 10
#define SleepingRegenerationRate 3


#pragma mark - Image Name Strings

static NSString *SleepingImageNameString = @"sleeping.png";
static NSString *GrumpyImageNameString = @"grumpy.png";
static NSString *AppleImageNameString = @"apple.png";
static NSString *BucketImageNameString = @"bucket.png";
static NSString *DefaultImageNameString = @"default.png";


@interface LPGPetModel ()

@end

@implementation LPGPetModel

@synthesize currentImageName = _currentImageName;


#pragma mark - Custom Initialization


- (instancetype)init {

    self = [super init];
    if (self) {
        _happy = YES;
        _restfulness = InitialRestfulness;
        _sleeping = NO;
        _regenerationRate = SleepingRegenerationRate;
        _defaultImageName = DefaultImageNameString;
        _grumpyImageName = GrumpyImageNameString;
        _sleepingImageName = SleepingImageNameString;
        _appleImageName = AppleImageNameString;
        _bucketImageName = BucketImageNameString;
        _currentImageName = _defaultImageName;
        [self registerNotifications];
    }
    return self;
}


#pragma mark - Getters and Setters


-(void)setRestfulness:(int)restfulness {
    if (restfulness == -1) {
        self.currentImageName = self.grumpyImageName;
    }
    else if (restfulness == 0) {
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

    UIImage *image;
    
    if (self.isSleeping) {
        image = [UIImage imageNamed:self.sleepingImageName];
    }
    else if (self.isHappy) {
        image = [UIImage imageNamed:self.defaultImageName];
    }
    else {
        image = [UIImage imageNamed:self.grumpyImageName];
    }
    return image;
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


#pragma mark - Communication with View Controller


-(void)wakePet {
    self.sleeping = NO;
}

-(void)makePetSleep {
    self.sleeping = YES;
}

-(void)rubPetWithVelocity:(CGPoint)velocity {
    self.happy = velocity.x * velocity.x + velocity.y * velocity.y < [self getAlertness] * HappinessThreshold;
}

-(void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wakePet)
                                                 name:@"WakePetNotification"
                                               object:self.delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makePetSleep)
                                                 name:@"MakePetSleepNotification"
                                               object:self.delegate];
}

@end
