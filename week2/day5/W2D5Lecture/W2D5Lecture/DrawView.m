//
//  DrawView.m
//  W2D5Lecture
//
//  Created by atfelix on 2017-05-12.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DrawView.h"

#import "LineSegment.h"

#define CG_CONTEXT_SHOW_BACKTRACE 1

@interface DrawView ()

@property (nonatomic) NSMutableArray<LineSegment *> *points;

@end

@implementation DrawView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        _points = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context,
                                     [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, 10.0);

    for (LineSegment *line in self.points) {

        CGContextMoveToPoint(context, line.start.x, line.start.y);
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        CGContextStrokePath(context);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"begin touch");

    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];

    NSLog(@"touch began at %@", NSStringFromCGPoint(first));
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"move touch");

    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    CGPoint second = [touch locationInView:self];
    LineSegment *line = [[LineSegment alloc] initWithStart:first
                                                    andEnd:second];
    [self.points addObject:line];
    NSLog(@"%@", self.points);

    NSLog(@"touch move from %@ to %@", NSStringFromCGPoint(first), NSStringFromCGPoint(second));

    [self setNeedsDisplay];
}

@end
