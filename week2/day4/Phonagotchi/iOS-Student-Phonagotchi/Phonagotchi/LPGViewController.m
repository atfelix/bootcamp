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


#pragma mark Background Color Macros


#define BackgroundColorRedHue (252.0 / 255.0)
#define BackgroundColorGreenHue (240.0 / 255.0)
#define BackgroundColorBlueHue (228.0 / 255.0)
#define BackgroundColorAlphaValue (1.0)


#pragma mark Animation Times

#define MinimumPressDuration (0.15)
#define ProgressViewAnimationDurationTime (1)
#define PetResponseAnimationDurationTime (3)
#define PetResponsePlaceHolderAnimationDurationTime (1)
#define AnimationDurationTimeDictionaryKey (0)
#define SleepingRegenerationRateDictionaryKey (1)


#pragma mark Other Macros

#define PointsBelowScreen (100)

#define AccelerationDueToGravity (9.8)
#define SpeedUpTimeFactor (10.0)

#define ChooChooSound ((1 << 10) - 1)

#define NumberOfTapsRequiredToMakeNoise (2)


#pragma mark Static NSStrings


static NSString *RestfulnessLabelText = @"Restfulness";
static NSString *DefaultImageNameString = @"default.png";
static NSString *SleepingImageNameString = @"sleeping.png";
static NSString *GrumpyImageNameString = @"grumpy.png";
static NSString *AppleImageNameString = @"apple.png";
static NSString *BucketImageNameString = @"bucket.png";
static NSString *PetResponsePlaceholderString = @"Pet Response Goes Here";

@interface LPGViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic) LPGPetModel *petModel;

@property (nonatomic) UIScrollView *scrollView;

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
@property (nonatomic) UITapGestureRecognizer *singleTapGestureRecognizer;

@property (nonatomic) UITextField *textField;
@property (nonatomic) UIButton *button;
@property (nonatomic) UILabel *petResponseLabel;
@property (nonatomic) NSArray<NSString *> *petResponsesArray;
@property (nonatomic, assign) NSUInteger currentPetResponseIndex;

@property (nonatomic) UIImage *sleepingImage;
@property (nonatomic) UIImage *defaultImage;
@property (nonatomic) UIImage *grumpyImage;
@property (nonatomic) UIImage *appleImage;
@property (nonatomic) UIImage *bucketImage;

@end

@implementation LPGViewController

#pragma mark - View Life Cycle

-(void)viewDidLoad {
    [super viewDidLoad];

    self.petModel = [[LPGPetModel alloc] init];
    self.defaultImage = [UIImage imageNamed:DefaultImageNameString];
    self.grumpyImage = [UIImage imageNamed:GrumpyImageNameString];
    self.sleepingImage = [UIImage imageNamed:SleepingImageNameString];
    self.appleImage = [UIImage imageNamed:AppleImageNameString];
    self.bucketImage = [UIImage imageNamed:BucketImageNameString];
	
    self.view.backgroundColor = [UIColor colorWithRed:BackgroundColorRedHue
                                                green:BackgroundColorGreenHue
                                                 blue:BackgroundColorBlueHue
                                                alpha:BackgroundColorAlphaValue];

    [self createPetImageView];
    [self addBasketAndAppleViews];
    [self addFeedingAppleView];

    [self addRestfulnessLabel];
    [self addProgressView];
    [self addRestfulnessTimer];

    [self addMessageService];

    [self addGestureRecognizers];

    [self registerKeyboardNotifications];

    [self.view layoutIfNeeded];
}


#pragma mark - Pet Image View


-(void)createPetImageView {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = self.defaultImage;
    self.petImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.petImageView];

    self.petImageView.layer.borderColor = [UIColor redColor].CGColor;

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


#pragma mark - Feeding Views


-(void)addBasketAndAppleViews {
    [self addBasketView];
    [self addAppleView];
}

-(void)addBasketView {
    self.bucketImageView = [[UIImageView alloc] initWithImage:self.bucketImage];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.bucketImageView];
    
    [self addBucketImageViewConstraints];
}

-(void)addAppleView {
    self.appleImageView = [[UIImageView alloc] initWithImage:self.appleImage];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.userInteractionEnabled = YES;

    [self.bucketImageView addSubview:self.appleImageView];

    [self addAppleImageViewConstraints];
}

-(void)addFeedingAppleView {
    self.feedingAppleImageView = [[UIImageView alloc] initWithImage:self.appleImage];
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


#pragma mark - Restfulness View


-(void)addRestfulnessLabel {
    self.restfulnessLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.restfulnessLabel.text = RestfulnessLabelText;
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
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.petImageView
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0
                                  constant:-20.0].active = YES;
}

-(void)addRestfulnessTimer {
    self.restfulnessTimer = [NSTimer scheduledTimerWithTimeInterval:ProgressViewAnimationDurationTime
                                                             target:self
                                                           selector:@selector(runPetSimulation:)
                                                           userInfo:@{@(AnimationDurationTimeDictionaryKey):@(ProgressViewAnimationDurationTime),
                                                                      @(SleepingRegenerationRateDictionaryKey):@(self.petModel.regenerationRate)}
                                                            repeats:YES];

}

-(void)depleteRestfulness:(NSTimer *)timer {
    self.petModel.restfulness -= [[timer userInfo][@(AnimationDurationTimeDictionaryKey)] intValue];
    [self animateProgessView:timer];

    if ([self.petModel isFullyDepleted]) {
        [self makePetSleep];
    }
}

-(void)regenerateRestfulness:(NSTimer *)timer {
    self.petModel.restfulness += [[timer userInfo][@(AnimationDurationTimeDictionaryKey)] intValue] * [[timer userInfo][@(SleepingRegenerationRateDictionaryKey)] intValue];
    [self animateProgessView:timer];

    if (self.petModel.isFullyRested) {
        [self wakePet];
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


#pragma mark - Messaging Service


-(void)addMessageService {
    [self addButton];
    [self addTextField];
    [self addPetResponseLabel];
}

-(void)addButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"Send"
                 forState:UIControlStateNormal];

    [self.button addTarget:self
                    action:@selector(sendMessageToPet)
          forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.button];

    [self addButtonConstraints];
}

-(void)addTextField {
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"Send message";
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.delegate = self;

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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendMessageToPet];
    return YES;
}

-(void)sendMessageToPet {
    if (self.textField.text.length > 0) {
        self.petResponseLabel.text = self.petResponsesArray[self.currentPetResponseIndex];
        self.currentPetResponseIndex = (self.currentPetResponseIndex + 1) % self.petResponsesArray.count;

        [self animatePetResponse];

        self.textField.text = @"";
        [self wakePet];
    }
    [self.textField resignFirstResponder];
}

-(void)animatePetResponse {
    self.petResponseLabel.alpha = 1;
    self.petResponseLabel.textColor = [UIColor blueColor];

    [UIView animateWithDuration:PetResponseAnimationDurationTime
                     animations:^{
                         self.petResponseLabel.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.petResponseLabel.text = PetResponsePlaceholderString;
                         self.petResponseLabel.textColor = [UIColor grayColor];
                         [UIView animateWithDuration:PetResponsePlaceHolderAnimationDurationTime
                                          animations:^{
                                              self.petResponseLabel.alpha = 0.5;
                                          }];
                     }];
}

-(void)addPetResponseLabel {
    self.petResponsesArray = @[
                               @"Stop feeding me Apples.",
                               @"Can I vomit in your shoes?",
                               @"I'm not listening to you.  I'm a cat"
                               ];
    self.currentPetResponseIndex = 0;
    self.petResponseLabel = [[UILabel alloc] init];
    self.petResponseLabel.text = PetResponsePlaceholderString;
    self.petResponseLabel.textAlignment = NSTextAlignmentRight;
    self.petResponseLabel.textColor = [UIColor grayColor];
    self.petResponseLabel.alpha = 0.5;

    [self.view addSubview:self.petResponseLabel];

    [self addPetResponseLabelConstraints];
}

-(void)addPetResponseLabelConstraints {
    self.petResponseLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint constraintWithItem:self.petResponseLabel
                                 attribute:NSLayoutAttributeTrailingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.petResponseLabel
                                 attribute:NSLayoutAttributeTopMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.petImageView
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.petResponseLabel
                                 attribute:NSLayoutAttributeLeadingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.petResponseLabel
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:40.0].active = YES;
}

#pragma mark - Communication with Pet Model


-(void)rubPet {
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self wakePet];
    }
    else if (self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self isLocationOverPet:[self.panGestureRecognizer locationInView:self.view]];
        [self.petModel rubPetWithVelocity:[self.panGestureRecognizer velocityInView:self.petImageView]];
    }
}

-(void)attemptToFeedPet {

    CGPoint location = [self.longPressGestureRecognizer locationInView:self.view];

    if (self.petModel.isSleeping && self.longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self animateFeedingAppleDown:location];
    }
    else if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self wakePet];
    }
    else if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.feedingAppleImageView.center = location;
    }
    else if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self wakePet];
        ([self isLocationOverPet:location]) ? [self animateFeedPet] : [self animateFeedingAppleDown:location];
    }
}

-(void)petMakesNoise {
    if (self.doubleTapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self wakePet];

        AudioServicesPlaySystemSound(ChooChooSound);
    }
}

-(void)wakePet {
    [self changePetStateWithSleepingBool:NO];
}

-(void)makePetSleep {
    [self changePetStateWithSleepingBool:YES];
}

-(void)changePetStateWithSleepingBool:(BOOL)isSleeping {
    self.petModel.sleeping = isSleeping;
}

-(void)runPetSimulation:(NSTimer *)timer {
    if (self.petModel.isSleeping) {
        self.petImageView.image = self.sleepingImage;
        [self regenerateRestfulness:timer];
    }
    else {
        self.petImageView.image = self.defaultImage;
        [self depleteRestfulness:timer];
    }
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

    NSTimeInterval duration = [self calculateTimeToFallWithHeight:bottom - top
                                                       andGravity:AccelerationDueToGravity] / SpeedUpTimeFactor;

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
    [UIView animateWithDuration:[[timer userInfo][@(AnimationDurationTimeDictionaryKey)] intValue]
                     animations:^{
                         [self.progressView setProgress:[self.petModel getAlertness]
                                               animated:YES];
                     }];
}


#pragma mark - Keyboard Functions

// TODO: fix keyboard animation


-(void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShowsOnScreen:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHidesOffScreen:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowOnScreen:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHideOffScreen:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

-(void)keyboardShowsOnScreen:(NSNotification *)notification {
    CGSize size = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 -size.height,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);

    [self.view layoutIfNeeded];
}

-(void)keyboardDidShowOnScreen:(NSNotification *)NSNotification {

}

-(void)keyboardHidesOffScreen:(NSNotification *)notification {
    self.view.frame = CGRectMake(0,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);

    [self.view layoutIfNeeded];
}

-(void)keyboardDidHideOffScreen:(NSNotification *)notification {

}

-(void)dismissKeyboard:(UITapGestureRecognizer *)sender {
    [self wakePet];
    [self.view endEditing:YES];
}


#pragma mark - Shake Motion Logic

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self wakePet];
    }

    if ([super respondsToSelector:@selector(motionEnded:withEvent:)] ) {
        [super motionEnded:motion
                 withEvent:event];
    }
}


#pragma mark - Gesture Recognizers


-(void)addGestureRecognizers {
    [self addPanGestureRecognizer];
    [self addLongPressGestureRecognizerToFeedingAppleView];
    [self addDoubleTapGestureRecognizer];
    [self addSingleTapGestureRecognizer];
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
    self.doubleTapGestureRecognizer.numberOfTapsRequired = NumberOfTapsRequiredToMakeNoise;
    [self.petImageView addGestureRecognizer:self.doubleTapGestureRecognizer];
    self.doubleTapGestureRecognizer.delegate = self;
}

-(void)addSingleTapGestureRecognizer {
    self.singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:self.singleTapGestureRecognizer];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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

-(double)calculateTimeToFallWithHeight:(CGFloat)height andGravity:(CGFloat)gravity {
    return sqrt(2.0 * height / gravity);
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
