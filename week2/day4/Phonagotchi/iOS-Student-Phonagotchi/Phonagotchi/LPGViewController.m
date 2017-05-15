//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@import AudioToolbox;

#import "LPGPetModel.h"

#define PointsBelowScreen 100
#define SpeedUpTimeFactor 10.0
#define MinimumPressDuration 0.15
#define ProgressViewAnimationDurationTime 1

@interface LPGViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) LPGPetModel *petModel;

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *feedingAppleImageView;

@property (nonatomic) UILabel *restfulnessLabel;
@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) NSTimer *restfulnessTimer;

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

@property (nonatomic) UITextField *textField;
@property (nonatomic) UIButton *button;

@property (nonatomic) UIImage *sleepingImage;
@property (nonatomic) UIImage *defaultImage;
@property (nonatomic) UIImage *grumpyImage;

@end

@implementation LPGViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.petModel = [[LPGPetModel alloc] init];
    self.defaultImage = [UIImage imageNamed:@"default.png"];
    self.grumpyImage = [UIImage imageNamed:@"grumpy.png"];
    self.sleepingImage = [UIImage imageNamed:@"sleeping.png"];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];

    [self createPetImageView];
    [self addBasketAndAppleViews];
    [self addFeedingAppleView];
    [self addPanGestureRecognizer];

    [self addRestfulnessLabel];
    [self addProgressView];
    [self addRestfulnessTimer];

    [self addButtonAndTextField];

    [self addGestureRecognizers];

    [self.view layoutIfNeeded];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        self.petModel.sleeping = NO;
        self.petImageView.image = self.defaultImage;
    }

    if ([super respondsToSelector:@selector(motionEnded:withEvent:)] ) {
        [super motionEnded:motion
                 withEvent:event];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Pet Image View


-(void)createPetImageView {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
    self.petImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.petImageView];

    self.petImageView.layer.borderColor = [UIColor redColor].CGColor;
    self.petImageView.layer.borderWidth = 2.0;

    [self addPetImageViewConstraints];
}

-(void)addPetImageViewConstraints {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}


#pragma mark - Gesture Recognizers


-(void)addGestureRecognizers {
    [self addPanGestureRecognizer];
    [self addLongPressGestureRecognizerToFeedingAppleView];
    [self addDoubleTapGestureRecognizer];
}


-(void)addPanGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(rubPet)];
    [self.petImageView addGestureRecognizer:self.panGestureRecognizer];
    self.panGestureRecognizer.delegate = self;
}

-(void)addLongPressGestureRecognizerToFeedingAppleView {
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(attemptToFeedPet)];
    self.longPressGestureRecognizer.minimumPressDuration = MinimumPressDuration;
    [self.feedingAppleImageView addGestureRecognizer:self.longPressGestureRecognizer];
}

-(void)addDoubleTapGestureRecognizer {
    self.doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(petMakesNoise)];
    self.doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.petImageView addGestureRecognizer:self.doubleTapGestureRecognizer];
    self.doubleTapGestureRecognizer.delegate = self;
}


#pragma mark - Basket and Apple Views


-(void)addBasketAndAppleViews {
    [self addBasketView];
    [self addAppleView];
}

-(void)addBasketView {
    self.bucketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bucket.png"]];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.bucketImageView];
    
    [self addBucketImageViewConstraints];
}

-(void)addAppleView {
    self.appleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.userInteractionEnabled = YES;

    [self.bucketImageView addSubview:self.appleImageView];

    [self addAppleImageViewConstraints];
}

-(void)addFeedingAppleView {
    self.feedingAppleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.png"]];
    self.feedingAppleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.feedingAppleImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.feedingAppleImageView];

    [self addFeedingAppleImageViewConstraints];
    [self.view bringSubviewToFront:self.feedingAppleImageView];

    [self addLongPressGestureRecognizerToFeedingAppleView];
}

-(void)addFeedingAppleImageViewConstraints {
    [NSLayoutConstraint constraintWithItem:self.feedingAppleImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.appleImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.feedingAppleImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.feedingAppleImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.feedingAppleImageView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.appleImageView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.feedingAppleImageView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.appleImageView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [self.view layoutIfNeeded];
}

-(void)addBucketImageViewConstraints {
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeLeadingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeWidth
                                multiplier:0.3
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bucketImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bucketImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
}

-(void)addAppleImageViewConstraints {
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bucketImageView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bucketImageView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bucketImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:0.6
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.appleImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
}


#pragma mark - Communication with Pet Model


-(void)rubPet {
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.petModel.sleeping = NO;
    }
    else if (self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self isLocationOverPet:[self.panGestureRecognizer locationInView:self.view]];
        [self.petModel rubPetWithVelocity:[self.panGestureRecognizer velocityInView:self.petImageView]];
        self.petImageView.image = (self.petModel.isHappy) ? self.defaultImage : self.grumpyImage;
    }
    else if (self.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.petImageView.image = (self.petModel.isSleeping) ? self.sleepingImage : self.defaultImage;
    }

}

-(void)attemptToFeedPet {

    self.petModel.sleeping = NO;
    self.petImageView.image = self.defaultImage;

    CGPoint location = [self.longPressGestureRecognizer locationInView:self.view];

    if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.feedingAppleImageView.center = location;
    }
    else if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.petModel.isSleeping || ![self isLocationOverPet:location]) {
            [self animateFeedingAppleDown:location];
        }
        else {
            [self animateFeedPet];
        }
    }
}

-(void)petMakesNoise {
    if (self.doubleTapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.petModel.sleeping = NO;
        self.petImageView.image = self.defaultImage;

        AudioServicesPlaySystemSound((1 << 10) - 1);
    }
}


#pragma mark - Restfulness methods


-(void)addRestfulnessLabel {
    self.restfulnessLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.restfulnessLabel.text = @"Restfulness";
    [self.view addSubview:self.restfulnessLabel];

    [self addRestfulnessLabelConstraints];
}

-(void)addRestfulnessLabelConstraints {
    self.restfulnessLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.restfulnessLabel
                                 attribute:NSLayoutAttributeLeadingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.restfulnessLabel
                                 attribute:NSLayoutAttributeTopMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:20.0].active = YES;
}

-(void)addRestfulnessTimer {
    self.restfulnessTimer = [NSTimer scheduledTimerWithTimeInterval:ProgressViewAnimationDurationTime
                                                             target:self
                                                           selector:@selector(runPetSimulation:)
                                                           userInfo:@{@"animationDurationTime":@(ProgressViewAnimationDurationTime),
                                                                      @"sleepingRegenerationRate":@(self.petModel.regenerationRate)}
                                                            repeats:YES];

}

-(void)runPetSimulation:(NSTimer *)timer {
    if (self.petModel.isSleeping) {
        [self regenerateRestfulness:timer];
    }
    else {
        [self depleteRestfulness:timer];
    }
}

-(void)depleteRestfulness:(NSTimer *)timer {
    self.petModel.restfulness -= [[timer userInfo][@"animationDurationTime"] intValue];
    [self animateProgessView:timer];

    if ([self.petModel isFullyDepleted]) {
        self.petModel.sleeping = YES;
        self.petImageView.image = self.sleepingImage;
    }
}

-(void)regenerateRestfulness:(NSTimer *)timer {
    self.petModel.restfulness += [[timer userInfo][@"animationDurationTime"] intValue] * [[timer userInfo][@"sleepingRegenerationRate"] intValue];
    [self animateProgessView:timer];

    if (self.petModel.isFullyRested) {
        self.petModel.sleeping = NO;
        self.petImageView.image = self.defaultImage;
    }
}

-(void)addProgressView {
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progressTintColor = [UIColor blueColor];
    [self.progressView setProgress:[self.petModel getAlertness]
                          animated:NO];
    [self.view addSubview:self.progressView];

    [self addProgressViewConstraints];
}

-(void)addProgressViewConstraints {
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.progressView
                                 attribute:NSLayoutAttributeLeadingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.restfulnessLabel
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.progressView
                                 attribute:NSLayoutAttributeTrailingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:-5.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.progressView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.restfulnessLabel
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0].active = YES;
}


#pragma mark - Animations


-(void)animateFeedPet {
    
    [UIView animateWithDuration:1.0
                          delay:0.2
                        options:0
                     animations:^{
                         self.feedingAppleImageView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.view setNeedsLayout];
                         self.feedingAppleImageView.alpha = 1;
                     }];
}

-(void)animateFeedingAppleDown:(CGPoint)location {

    CGFloat top = location.y;
    CGFloat bottom = self.view.bounds.size.height + PointsBelowScreen;

    NSTimeInterval duration = sqrt(2 * (bottom - top) / 9.8) / SpeedUpTimeFactor;

    [UIView animateWithDuration:duration
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.feedingAppleImageView.center = CGPointMake(location.x, bottom);
                     }
                     completion:^(BOOL finished) {
                         [self.view setNeedsLayout];
                     }];
}

-(void)animateProgessView:(NSTimer *)timer {
    [UIView animateWithDuration:[[timer userInfo][@"animationDurationTime"] intValue] 
                     animations:^{
                         [self.progressView setProgress:[self.petModel getAlertness]
                                               animated:YES];
                     }];
}


#pragma mark - Button and TextField


-(void)addButtonAndTextField {
    [self addButton];
    [self addTextField];
}

-(void)addButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"Send"
                 forState:UIControlStateNormal];

    [self.view addSubview:self.button];

    [self addButtonConstraints];
}

-(void)addTextField {
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"Send message";
    self.textField.textAlignment = NSTextAlignmentRight;

    [self.view addSubview:self.textField];
    [self addTextFieldConstraints];
}

-(void)addButtonConstraints {
    self.button.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeTrailingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:-5.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
}

-(void)addTextFieldConstraints {
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint constraintWithItem:self.textField
                                 attribute:NSLayoutAttributeTrailingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:-5.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textField
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.button
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textField
                                 attribute:NSLayoutAttributeLeadingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bucketImageView
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:20.0].active = YES;
}



#pragma mark - ViewController helper functions


-(BOOL)isLocationOverPet:(CGPoint)location {

    CGPoint locationOverPet = [self.view convertPoint:location
                                               toView:self.petImageView];

    return (0 <= locationOverPet.x
            && locationOverPet.x <= self.petImageView.frame.size.width
            && 0 <= locationOverPet.y
            && locationOverPet.y <= self.petImageView.frame.size.height);
}


-(UIColor *) colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0, 0, 0, 0};

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 colorSpace,
                                                 kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.view.layer renderInContext:context];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    return [UIColor colorWithRed:pixel[0] / 255.0
                           green:pixel[1] / 255.0
                            blue:pixel[2] / 255.0
                           alpha:pixel[3] / 255.0];
}

@end
