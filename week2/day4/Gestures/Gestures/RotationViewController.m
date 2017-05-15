//
//  RotationViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@end

@implementation RotationViewController

- (IBAction)rotateBlackView:(UIRotationGestureRecognizer *)sender {
    sender.view.transform = CGAffineTransformMakeRotation(sender.rotation);
}

@end
