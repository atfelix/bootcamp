//
//  SwipeViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (nonatomic, assign, getter=isSwiped) BOOL swiped;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@end

@implementation SwipeViewController

- (IBAction)whiteViewSwiped:(UISwipeGestureRecognizer *)sender {
    CGRect frame = sender.view.frame;

    if (self.isSwiped && (sender.direction == UISwipeGestureRecognizerDirectionRight)) {
        [UIView animateWithDuration:0.75
                              delay:0
             usingSpringWithDamping:0.175
              initialSpringVelocity:0.125
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             sender.view.frame = CGRectMake(frame.origin.x,
                                                            frame.origin.y,
                                                            frame.size.width + 100,
                                                            frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             self.swiped ^= YES;
                         }];
    }
    else if (!self.isSwiped && (sender.direction == UISwipeGestureRecognizerDirectionLeft)) {
        [UIView animateWithDuration:0.75
                              delay:0
             usingSpringWithDamping:0.175
              initialSpringVelocity:0.125
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             sender.view.frame = CGRectMake(frame.origin.x,
                                                            frame.origin.y,
                                                            frame.size.width - 100,
                                                            frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             self.swiped ^= YES;
                         }];
    }
}


@end
