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
    if (self.isSwiped && (sender.direction == UISwipeGestureRecognizerDirectionRight)) {
        [self animateSwipeWithSender:sender];
    }
    else if (!self.isSwiped && (sender.direction == UISwipeGestureRecognizerDirectionLeft)) {
        [self animateSwipeWithSender:sender];
    }
}

-(void)animateSwipeWithSender:(UISwipeGestureRecognizer *)sender {
    int direction = (sender.direction == UISwipeGestureRecognizerDirectionLeft) ? -1 : +1;
    [UIView animateWithDuration:0.75
                          delay:0
         usingSpringWithDamping:0.175
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sender.view.frame = CGRectMake(sender.view.frame.origin.x,
                                                        sender.view.frame.origin.y,
                                                        sender.view.frame.size.width + direction * 100,
                                                        sender.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.swiped ^= YES;
                     }];
}

@end
