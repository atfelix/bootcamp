//
//  PinchViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController ()

@end

@implementation PinchViewController

-(void)viewDidLoad {

    [super viewDidLoad];

    UIView *square = [[UIView alloc] initWithFrame:CGRectZero];
    square.frame = CGRectMake(0, 0, 100, 100);
    square.center = self.view.center;
    square.backgroundColor = [UIColor whiteColor];

    [square addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(squarePinched:)]];

    [self.view addSubview:square];
}

-(IBAction)squarePinched:(UIPinchGestureRecognizer *)sender {
    sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
}

@end
