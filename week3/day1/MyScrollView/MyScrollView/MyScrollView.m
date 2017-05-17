//
//  MyScrollView.m
//  MyScrollView
//
//  Created by atfelix on 2017-05-17.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        _panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(handlePan:)];
        [self addGestureRecognizer:_panGR];
        _contentSize = CGSizeMake(1000, 1000);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)handlePan:(UIPanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self];
    CGPoint oldCenter = sender.view.center;

    sender.view.center = CGPointMake(MIN(500, oldCenter.x + translationInView.x),
                                     MIN(500, oldCenter.y + translationInView.y));

    [sender setTranslation:CGPointZero
                    inView:sender.view];
}

@end
