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

-(void) update:(NSUInteger *) ptrToIndex andData:(NSArray *) array andUIImageView:(UIImageView *) view inDirection: (BOOL) direction {
    *ptrToIndex = (*ptrToIndex +((direction) ? 1 : array.count - 1)) % array.count;
    view.image = array[*ptrToIndex];
}

-(void) getNextEye {
    [self update:&_currentEyeIndex
         andData:self.data.eyeImages
  andUIImageView:self.eyeView
     inDirection:YES];
}

-(void) getPreviousEye {
    [self update:&_currentEyeIndex
         andData:self.data.eyeImages
  andUIImageView:self.eyeView
     inDirection:NO];
}

-(void) getNextNose {
    [self update:&_currentNoseIndex
         andData:self.data.noseImages
  andUIImageView:self.noseView
     inDirection:YES];
}

-(void) getPreviousNose {
    [self update:&_currentNoseIndex
         andData:self.data.noseImages
  andUIImageView:self.noseView
     inDirection:NO];
}

-(void) getNextMouth {
    [self update:&_currentMouthIndex
         andData:self.data.mouthImages
  andUIImageView:self.mouthView
     inDirection:YES];
}

-(void) getPreviousMouth {
    [self update:&_currentMouthIndex
         andData:self.data.mouthImages
  andUIImageView:self.mouthView
}

@end
