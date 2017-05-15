//
//  EdgeViewController.m
//  Gestures
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "EdgeViewController.h"

#define Threshold 100
#define Displacement 365


@interface EdgeViewController ()

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (nonatomic, assign, getter=isSwiped) BOOL swiped;
@property (nonatomic, assign) CGFloat originalX;

@end

@implementation EdgeViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    UIScreenEdgePanGestureRecognizer *leftEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                                         action:@selector(greenViewEdgePanned:)];
    UIScreenEdgePanGestureRecognizer *rightEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                                        action:@selector(greenViewEdgePanned:)];

    leftEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    rightEdgePanGestureRecognizer.edges = UIRectEdgeRight;

    [self.greenView addGestureRecognizer:leftEdgePanGestureRecognizer];
    [self.greenView addGestureRecognizer:rightEdgePanGestureRecognizer];

}

-(void)greenViewEdgePanned:(UIScreenEdgePanGestureRecognizer*)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalX = sender.view.frame.origin.x;
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self translateGreenView:sender];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self swipeGreenView:sender];
    }
}

-(void)translateGreenView:(UIScreenEdgePanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;

    sender.view.center = CGPointMake(oldCenter.x + translationInView.x,
                                     sender.view.center.y);
    [sender setTranslation:CGPointZero
                    inView:sender.view];
}

-(void)swipeGreenView:(UIScreenEdgePanGestureRecognizer *)sender {

    if (!self.isSwiped && (self.originalX - [sender locationInView:self.view].x >= Threshold)) {
        self.originalX -= Displacement;
        self.swiped ^= YES;
    }
    else if (self.isSwiped && ([sender locationInView:self.view].x - self.originalX >= Threshold)) {
        self.originalX += Displacement;
        self.swiped ^= YES;
    }
    [self animateGreenView:sender];
}

-(void)animateGreenView:(UIScreenEdgePanGestureRecognizer *)sender {

    [UIView animateWithDuration:0.75
                          delay:0
         usingSpringWithDamping:0.175
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sender.view.frame = CGRectMake(self.originalX,
                                                        sender.view.frame.origin.y,
                                                        sender.view.frame.size.width,
                                                        sender.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.swiped ^= YES;
                     }];
}

@end
