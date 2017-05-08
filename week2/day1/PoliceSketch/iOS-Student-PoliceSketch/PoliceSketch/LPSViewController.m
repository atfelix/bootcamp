//
//  LPSViewController.m
//  PoliceSketch
//
//  Created by Steven Masuch on 2014-07-20.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPSViewController.h"

#import "LPSDataModel.h"

@interface LPSViewController ()

@property (nonatomic) LPSDataModel *data;

@property (nonatomic) NSUInteger currentEyeIndex;
@property (nonatomic) NSUInteger currentNoseIndex;
@property (nonatomic) NSUInteger currentMouthIndex;

@property (nonatomic) IBOutlet UIImageView *eyeView;
@property (nonatomic) IBOutlet UIImageView *noseView;
@property (nonatomic) IBOutlet UIImageView *mouthView;

@property (nonatomic) IBOutlet UIButton *leftEyeButton;
@property (nonatomic) IBOutlet UIButton *rightEyeButton;
@property (nonatomic) IBOutlet UIButton *leftNoseButton;
@property (nonatomic) IBOutlet UIButton *rightNoseButton;
@property (nonatomic) IBOutlet UIButton *leftMouthButton;
@property (nonatomic) IBOutlet UIButton *rightMouthButton;

@end

@implementation LPSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.data = [[LPSDataModel alloc] init];

    [self.leftEyeButton addTarget:self
                           action:@selector(getPreviousEye)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.rightEyeButton addTarget:self
                            action:@selector(getNextEye)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.leftNoseButton addTarget:self
                            action:@selector(getPreviousNose)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.rightNoseButton addTarget:self
                             action:@selector(getNextNose)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.leftMouthButton addTarget:self
                             action:@selector(getPreviousMouth)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.rightMouthButton addTarget:self
                              action:@selector(getNextMouth)
                    forControlEvents:UIControlEventTouchUpInside];
    
    // Here is where you will create the buttons & image views and add them to the view.
}

-(void) getNextEye {
    self.currentEyeIndex = (self.currentEyeIndex + 1) % self.data.eyeImages.count;
    self.eyeView.image = self.data.eyeImages[self.currentEyeIndex];
}

-(void) getPreviousEye {
    self.currentEyeIndex = (self.currentEyeIndex - 1 + self.data.eyeImages.count) % self.data.eyeImages.count;
    self.eyeView.image = self.data.eyeImages[self.currentEyeIndex];
}

-(void) getNextNose {
    self.currentNoseIndex = (self.currentNoseIndex + 1) % self.data.noseImages.count;
    self.noseView.image = self.data.noseImages[self.currentNoseIndex];
}

-(void) getPreviousNose {
    self.currentNoseIndex = (self.currentNoseIndex - 1 + self.data.noseImages.count) % self.data.noseImages.count;
    self.noseView.image = self.data.noseImages[self.currentNoseIndex];
}

-(void) getNextMouth {
    self.currentMouthIndex = (self.currentMouthIndex + 1) % self.data.mouthImages.count;
    self.mouthView.image = self.data.mouthImages[self.currentMouthIndex];
}

-(void) getPreviousMouth {
    self.currentMouthIndex = (self.currentMouthIndex - 1 + self.data.mouthImages.count) % self.data.mouthImages.count;
    self.mouthView.image = self.data.mouthImages[self.currentMouthIndex];
}

@end
