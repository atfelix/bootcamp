//
//  TapViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TapViewController.h"

@interface TapViewController ()

@end

@implementation TapViewController


- (IBAction)squareTapped:(UITapGestureRecognizer *)sender {
    sender.view.backgroundColor = ([sender.view.backgroundColor isEqual:[UIColor whiteColor]]) ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
