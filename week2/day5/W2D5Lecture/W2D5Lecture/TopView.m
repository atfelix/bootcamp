//
//  TopView.m
//  W2D5Lecture
//
//  Created by atfelix on 2017-05-12.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TopView.h"

@implementation TopView

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(100, 100, 100, 50));

    CGContextSetFillColorWithColor(context,
                                   [UIColor yellowColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(200, 200, 150, 50));

    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 20, 30);
    CGContextAddLineToPoint(context, 200, 30);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);

    CGPoint points[] = {
        CGPointMake(10, 100),
        CGPointMake(10, 200)
    };

    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextAddLines(context, points, 2);
    CGContextStrokeLineSegments(context, points, 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
