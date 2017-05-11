//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@import UIKit;
#import "LPGPetModel.h"

@interface LPGViewController ()

@property (nonatomic) LPGPetModel *petModel;
@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) NSArray<UIImage *> *imageArray;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.petModel = [[LPGPetModel alloc] init];
    self.imageArray = @[
                            [UIImage imageNamed:@"default.png"],
                            [UIImage imageNamed:@"grumpy.png"],
                            [UIImage imageNamed:@"sleeping.png"],
    ];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];

    [self createPetImageView];
    [self createGestureRecognizer];
}

-(void)rubPet {
    [self.petModel rubPetWithVelocity:[self.panGestureRecognizer velocityInView:self.petImageView]];
    self.petImageView.image = (self.petModel.isHappy) ? self.imageArray[0] : self.imageArray[1];
}

-(void)createPetImageView {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
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

-(void)createGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(rubPet)];
    [self.petImageView addGestureRecognizer:self.panGestureRecognizer];
}

@end
