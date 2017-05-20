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


#pragma mark Timer Dictionary Keys


#define AnimationDurationTimeDictionaryKey (0)
#define SleepingRegenerationRateDictionaryKey (1)
#define ProgressViewDictionaryKey (2)


#pragma mark Other Macros


#define PointsBelowScreen (100)

#define AccelerationDueToGravity (9.8)
#define SpeedUpTimeFactor (10.0)

#define ChooChooSound ((1 << 10) - 1)

#define NumberOfTapsRequiredToMakeNoise (2)


#pragma mark Static NSStrings


static NSString *RestfulnessLabelText = @"Restfulness";
static NSString *PetResponsePlaceholderString = @"Pet Response Goes Here";


@interface LPGViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate, PetDelegate>

@property (nonatomic) LPGPetModel *petModel;

@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *feedingAppleImageView;

@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) NSTimer *restfulnessTimer;

@property (nonatomic) UITextField *textField;
@property (nonatomic) UILabel *petResponseLabel;

@property (nonatomic, assign) NSUInteger currentPetResponseIndex;

@end

@implementation LPGViewController

#pragma mark - View Life Cycle


-(void)viewDidLoad {
    [super viewDidLoad];

    self.petModel = [[LPGPetModel alloc] init];

    self.view.backgroundColor = [UIColor colorWithRed:BackgroundColorRedHue
                                                green:BackgroundColorGreenHue
                                                 blue:BackgroundColorBlueHue
                                                alpha:BackgroundColorAlphaValue];

    [self createPetImageView];
    [self addBasketAndAppleViews];
    [self addFeedingAppleView];

    [self addProgressBar];

    [self addMessageService];

    [self addGestureRecognizers];

    [self registerKeyboardNotifications];

    self.petModel.delegate = self;

    [self.view layoutIfNeeded];
}


#pragma mark - Pet Image View


-(void)createPetImageView {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:self.petModel.currentImageName];
    self.petImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.petImageView];

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
    self.bucketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.petModel.bucketImageName]];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.userInteractionEnabled = YES;

    [self.view addSubview:self.bucketImageView];

    [self addBucketImageViewConstraints];
}

-(void)addAppleView {
    self.appleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.petModel.appleImageName]];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.userInteractionEnabled = YES;

    [self.bucketImageView addSubview:self.appleImageView];

    [self addAppleImageViewConstraints];
}

-(void)addFeedingAppleView {
    self.feedingAppleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.petModel.appleImageName]];
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


-(void)addProgressBar {
    UILabel *label = [self addRestfulnessLabel];
    [self addProgressViewNextToLabel:label];
    [self addRestfulnessTimer];
}


-(UILabel *)addRestfulnessLabel {
    UILabel *restfulnessLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    restfulnessLabel.text = RestfulnessLabelText;
    [self.view addSubview:restfulnessLabel];

    [self addConstraintsToLabel:restfulnessLabel];
    return restfulnessLabel;
}

-(void)addConstraintsToLabel:(UILabel *)label {

    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.petImageView
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0
                                                           constant:-20.0]];

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
        [self postMakePetSleepNotification];
    }
}

-(void)regenerateRestfulness:(NSTimer *)timer {
    self.petModel.restfulness += [[timer userInfo][@(AnimationDurationTimeDictionaryKey)] intValue] * [[timer userInfo][@(SleepingRegenerationRateDictionaryKey)] intValue];
    [self animateProgessView:timer];

    if (self.petModel.isFullyRested) {
        [self postWakeUpNotification];
    }
}

-(void)addProgressViewNextToLabel:(UILabel *)label {

    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progressTintColor = [UIColor blueColor];
    [self.progressView setProgress:[self.petModel getAlertness]
                          animated:NO];
    [self.view addSubview:self.progressView];
    [self addConstraintsToProgressView:self.progressView
                           nextToLabel:label];
}

-(void)addConstraintsToProgressView:(UIProgressView *)progressView nextToLabel:(UILabel *)label {

    progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressView
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:label
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0
                                                           constant:20.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressView
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0
                                                           constant:-5.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:label
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}


#pragma mark - Messaging Service


-(void)addMessageService {
    UIButton *button = [self addButton];
    [self addTextFieldOnTopOfButton:button];
    [self addPetResponseLabel];
}

-(UIButton *)addButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Send"
            forState:UIControlStateNormal];

    [button addTarget:self
               action:@selector(sendMessageToPet:)
     forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];

    [self addConstraintsToButton:(UIButton *)button];
    return button;
}

-(void)addTextFieldOnTopOfButton:(UIButton *)button {

    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"Send message";
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.delegate = self;

    [self.view addSubview:self.textField];
    [self addTextFieldConstraints:button];
}

-(void)addConstraintsToButton:(UIButton *)button {
    button.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0
                                                           constant:-5.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.0
                                                           constant:-10.0]];
}

-(void)addTextFieldConstraints:(UIButton *)button {
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
                                    toItem:button
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
    [self sendMessageToPet:nil];
    return YES;
}

-(void)sendMessageToPet:(id)sender {
    NSArray<NSString *> *array = @[
                                        @"Stop feeding me apples.",
                                        @"Can I vomit in your shoes?",
                                        @"I'm not listening to you.  I'm a cat."
    ];

    if (self.textField.text.length > 0) {
        self.petResponseLabel.text = array[self.currentPetResponseIndex];
        self.currentPetResponseIndex = (self.currentPetResponseIndex + 1) % array.count;

        [self animatePetResponse];

        self.textField.text = @"";
        [self postWakeUpNotification];
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


-(void)rubPet:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self postWakeUpNotification];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self postWakeUpNotification];
        [self isLocationOverPet:[sender locationInView:self.view]];
        [self.petModel rubPetWithVelocity:[sender velocityInView:self.petImageView]];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        self.petModel.happy = YES;
    }
}

-(void)attemptToFeedPet:(UILongPressGestureRecognizer *)sender {

    CGPoint location = [sender locationInView:self.view];

    if (self.petModel.isSleeping && sender.state == UIGestureRecognizerStateEnded) {
        [self animateFeedingAppleDown:location];
    }
    else if (sender.state == UIGestureRecognizerStateBegan) {
        [self postWakeUpNotification];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        self.feedingAppleImageView.center = location;
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self postWakeUpNotification];
        ([self isLocationOverPet:location]) ? [self animateFeedPet] : [self animateFeedingAppleDown:location];
    }
}

-(void)petMakesNoise:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self postWakeUpNotification];
        self.petModel.happy = YES;
        AudioServicesPlaySystemSound(ChooChooSound);
    }
}


-(void)changePetStateWithSleepingBool:(BOOL)isSleeping {
    self.petModel.sleeping = isSleeping;
}

-(void)runPetSimulation:(NSTimer *)timer {
    if (self.petModel.isSleeping) {
        [self regenerateRestfulness:timer];
    }
    else {
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
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHidesOffScreen:)
                                                 name:UIKeyboardWillHideNotification
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

-(void)keyboardHidesOffScreen:(NSNotification *)notification {
    self.view.frame = CGRectMake(0,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);

    [self.view layoutIfNeeded];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


#pragma mark - Shake Motion Logic

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self postWakeUpNotification];
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
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(rubPet:)];
    [self.petImageView addGestureRecognizer:panGR];
    panGR.delegate = self;
}

-(void)addLongPressGestureRecognizerToFeedingAppleView {
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(attemptToFeedPet:)];
    longPressGR.minimumPressDuration = MinimumPressDuration;
    [self.feedingAppleImageView addGestureRecognizer:longPressGR];
}

-(void)addDoubleTapGestureRecognizer {
    UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(petMakesNoise:)];
    doubleTapGR.numberOfTapsRequired = NumberOfTapsRequiredToMakeNoise;
    [self.petImageView addGestureRecognizer:doubleTapGR];
    doubleTapGR.delegate = self;
}

-(void)addSingleTapGestureRecognizer {
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:singleTapGR];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }
    else if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
             && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }
    else {
        return YES;
    }
}


#pragma mark PetDelegate Method

-(void)loadImageWithNewRestfulness:(int)restfulness {
    if (self.petModel.restfulness == 0 && restfulness == -1) {
        self.petModel.happy = NO;
        self.petModel.sleeping = NO;
    }
    else if (self.petModel.isSleeping) {
        self.petModel.happy = YES;
    }
    self.petImageView.image = [UIImage imageNamed:self.petModel.currentImageName];
}

-(void)postWakeUpNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WakePetNotification"
                                                        object:self];
}

-(void)postMakePetSleepNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MakePetSleepNotification"
                                                        object:self];
}



#pragma mark - ViewController helper functions


-(BOOL)isLocationOverPet:(CGPoint)location {
    return CGRectContainsPoint(self.petImageView.bounds, [self.view convertPoint:location
                                                                         toView:self.petImageView]);
}

-(double)calculateTimeToFallWithHeight:(CGFloat)height andGravity:(CGFloat)gravity {
    return sqrt(2.0 * height / gravity);
}


@end
