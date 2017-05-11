//
//  LPAViewController.m
//  Autolayout
//
//  Created by Steven Masuch on 2014-07-20.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPAViewController.h"

#define NUM_BLUE_BOXES 3

@interface LPAViewController ()

@property (nonatomic, weak) UIButton *squareButton;
@property (nonatomic, weak) UIButton *portraitButton;
@property (nonatomic, weak) UIButton *landscapeButton;
@property (nonatomic, weak) UIButton *yellowButton;

@property (nonatomic, weak) UIView *framingView;
@property (nonatomic, weak) NSLayoutConstraint *framingViewHeightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *framingViewWidthConstraint;

@property (nonatomic, weak) NSLayoutConstraint *blueViewCenterYConstraint1;
@property (nonatomic, weak) NSLayoutConstraint *blueViewCenterYConstraint2;
@property (nonatomic, weak) NSLayoutConstraint *blueViewCenterYConstraint3;

@property (nonatomic, weak) UIView *yellowView;

@end

@implementation LPAViewController

- (void)viewDidLoad
{


    [super viewDidLoad];

    UIButton *squareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [squareButton setTitle:@"Square" forState:UIControlStateNormal];
    [squareButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:squareButton];
    squareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.squareButton = squareButton;

    UIButton *portraitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [portraitButton setTitle:@"Portrait" forState:UIControlStateNormal];
    [portraitButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:portraitButton];
    portraitButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.portraitButton = portraitButton;

    UIButton *landscapeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [landscapeButton setTitle:@"Landscape" forState:UIControlStateNormal];
    [landscapeButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landscapeButton];
    landscapeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.landscapeButton = landscapeButton;

    UIButton *yellowButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [yellowButton setTitle:@"Toggle Yellow Button" forState:UIControlStateNormal];
    [yellowButton addTarget:self action:@selector(toggleYellowView) forControlEvents:UIControlEventTouchUpInside];
    yellowButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yellowButton];


    UIView *framingView = [[UIView alloc] initWithFrame:CGRectZero];
    framingView.translatesAutoresizingMaskIntoConstraints = NO;
    framingView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:framingView];
    self.framingView = framingView;

    NSString *buttonsHorizontalConstraintsFormat = @"|[squareButton(==portraitButton)][portraitButton(==landscapeButton)][landscapeButton(==yellowButton)][yellowButton]|";
    NSArray *buttonsHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:buttonsHorizontalConstraintsFormat
                                                                                    options:NSLayoutFormatAlignAllCenterY
                                                                                    metrics:nil
                                                                                      views:NSDictionaryOfVariableBindings(squareButton, portraitButton, landscapeButton, yellowButton)];
    [NSLayoutConstraint activateConstraints:buttonsHorizontalConstraints];

    NSLayoutConstraint *squareButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:squareButton
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0
                                                                                     constant:-50.0];
    squareButtonBottomConstraint.active = YES;

    NSLayoutConstraint *framingViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:framingView
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                   multiplier:1.0
                                                                                     constant:0.0];
    framingViewCenterXConstraint.active = YES;

    NSLayoutConstraint *framingViewCenterY = [NSLayoutConstraint constraintWithItem:framingView
                                                                          attribute:NSLayoutAttributeCenterY
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeCenterY
                                                                         multiplier:1.0
                                                                           constant:-50.0];
    framingViewCenterY.active = YES;

    self.framingViewHeightConstraint = [NSLayoutConstraint constraintWithItem:framingView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:500.0];
    self.framingViewHeightConstraint.active = YES;

    self.framingViewWidthConstraint = [NSLayoutConstraint constraintWithItem:framingView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:500.0];
    self.framingViewWidthConstraint.active = YES;

    
    // Set up your views and constraints here

    [self addPurpleBox];
    [self addRedBox];
    [self addBlueBoxes];
    [self addYellowView];

}

#pragma mark - Purple View

-(void) addPurpleBox {

    UIView *purpleView = [[UIView alloc] initWithFrame:CGRectZero];
    purpleView.translatesAutoresizingMaskIntoConstraints = NO;
    purpleView.backgroundColor = [UIColor purpleColor];
    [self.framingView addSubview:purpleView];

    [NSLayoutConstraint constraintWithItem:purpleView
                                 attribute:NSLayoutAttributeRightMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeRightMargin
                                multiplier:1.0
                                  constant:-20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:purpleView
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:-20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:purpleView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:purpleView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:305.0/500.0
                                  constant:0.0].active = YES;
}

#pragma mark - Red View

-(void) addRedBox {

    UIView *redView = [[UIView alloc] initWithFrame:CGRectZero];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.framingView addSubview:redView];

    [NSLayoutConstraint constraintWithItem:redView
                                 attribute:NSLayoutAttributeRightMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeRightMargin
                                multiplier:1.0
                                  constant:-20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView
                                 attribute:NSLayoutAttributeTopMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0
                                  constant:20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:150.0].active = YES;

    [self addOrangeBoxesTo:redView];
}

#pragma mark - Orange Views

-(void) addOrangeBoxesTo:(UIView *)redView {

    UIView *orangeView1 = [[UIView alloc] initWithFrame:CGRectZero];
    orangeView1.translatesAutoresizingMaskIntoConstraints = NO;
    orangeView1.backgroundColor = [UIColor orangeColor];
    [redView addSubview:orangeView1];

    [NSLayoutConstraint constraintWithItem:orangeView1
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView1
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView1
                                 attribute:NSLayoutAttributeRightMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:redView
                                 attribute:NSLayoutAttributeRightMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView1
                                 attribute:NSLayoutAttributeTopMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:redView
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0
                                  constant:10.0].active = YES;

    UIView *orangeView2 = [[UIView alloc] initWithFrame:CGRectZero];
    orangeView2.translatesAutoresizingMaskIntoConstraints = NO;
    orangeView2.backgroundColor = [UIColor orangeColor];
    [redView addSubview:orangeView2];

    [NSLayoutConstraint constraintWithItem:orangeView2
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:70.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView2
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView2
                                 attribute:NSLayoutAttributeRightMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:orangeView1
                                 attribute:NSLayoutAttributeLeftMargin
                                multiplier:1.0
                                  constant:-25.0].active = YES;
    [NSLayoutConstraint constraintWithItem:orangeView2
                                 attribute:NSLayoutAttributeTopMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:redView
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0
                                  constant:10.0].active = YES;

}

#pragma mark - Blue Views

-(void) addBlueBoxes {

    [self.view layoutIfNeeded];

    CGFloat height = self.framingView.frame.size.height;

    UIView *blueView1 = [[UIView alloc] initWithFrame:CGRectZero];
    blueView1.translatesAutoresizingMaskIntoConstraints = NO;
    blueView1.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueView1];

    [NSLayoutConstraint constraintWithItem:blueView1
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView1
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView1
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    self.blueViewCenterYConstraint1 = [NSLayoutConstraint constraintWithItem:blueView1
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.framingView
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                  multiplier:1.0
                                                                    constant:height / (NUM_BLUE_BOXES + 1)];
    self.blueViewCenterYConstraint1.active = YES;

    UIView *blueView2 = [[UIView alloc] initWithFrame:CGRectZero];
    blueView2.translatesAutoresizingMaskIntoConstraints = NO;
    blueView2.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueView2];

    [NSLayoutConstraint constraintWithItem:blueView2
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView2
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView2
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    self.blueViewCenterYConstraint2 = [NSLayoutConstraint constraintWithItem:blueView2
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.framingView
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                  multiplier:1.0
                                                                    constant:height / (NUM_BLUE_BOXES + 1) * 2];
    self.blueViewCenterYConstraint2.active = YES;

    UIView *blueView3 = [[UIView alloc] initWithFrame:CGRectZero];
    blueView3.translatesAutoresizingMaskIntoConstraints = NO;
    blueView3.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueView3];

    [NSLayoutConstraint constraintWithItem:blueView3
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView3
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView3
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    self.blueViewCenterYConstraint3 = [NSLayoutConstraint constraintWithItem:blueView3
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.framingView
                                                                   attribute:NSLayoutAttributeTopMargin
                                                                  multiplier:1.0
                                                                    constant:height / (NUM_BLUE_BOXES + 1) * 3];
    self.blueViewCenterYConstraint3.active = YES;
}

-(void) reconstrainBlueViewsWithHeight:(CGFloat) height {
    self.blueViewCenterYConstraint1.constant = height / (NUM_BLUE_BOXES + 1);
    self.blueViewCenterYConstraint2.constant = 2 * height / (NUM_BLUE_BOXES + 1);
    self.blueViewCenterYConstraint3.constant = 3 * height / (NUM_BLUE_BOXES + 1);
}

#pragma mark - Yellow View

-(void) addYellowView {

    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectZero];
    yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.framingView addSubview:yellowView];

    [NSLayoutConstraint constraintWithItem:yellowView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:150.0].active = YES;
    [NSLayoutConstraint constraintWithItem:yellowView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:yellowView
                                 attribute:NSLayoutAttributeLeftMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeLeftMargin
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:yellowView
                                 attribute:NSLayoutAttributeBottomMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.framingView
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:0.0].active = YES;

    yellowView.hidden = YES;

    self.yellowView = yellowView;
}

-(void) toggleYellowView {
    self.yellowView.hidden ^= YES;
    [self.view layoutIfNeeded];
}

/**
 Resize the frame of the framing view depending on which button was pressed.
 */
- (void)resizeFramingView:(id)sender
{
    CGFloat newWidth = 0.0;
    CGFloat newHeight = 0.0;
    
    if (sender == self.squareButton) {
        newWidth = 500.0;
        newHeight = 500.0;
    } else if (sender == self.portraitButton) {
        newWidth = 350.0;
        newHeight = 550.0;
    } else if (sender == self.landscapeButton) {
        newWidth = 900.0;
        newHeight = 300.0;
    }

    [self reconstrainBlueViewsWithHeight:newHeight];

    [UIView animateWithDuration:2.0 animations:^(){
        self.framingViewHeightConstraint.constant = newHeight;
        self.framingViewWidthConstraint.constant = newWidth;
        [self.view layoutIfNeeded];
    }];
}

@end
