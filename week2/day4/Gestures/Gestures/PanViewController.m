//
//  PanViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PanViewController.h"

@interface PanViewController ()

@end

@implementation PanViewController

- (IBAction)redViewPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;

    sender.view.center = CGPointMake(oldCenter.x + translationInView.x,
                                     oldCenter.y + translationInView.y);
    [sender setTranslation:CGPointZero
                    inView:sender.view];
}

@end
