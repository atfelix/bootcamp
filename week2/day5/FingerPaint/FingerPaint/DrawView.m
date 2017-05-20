//
//  DrawView.m
//  FingerPaint
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DrawView.h"

#import "LineSegment.h"

@interface DrawView ()

@property (nonatomic) NSMutableArray *lines;

@end

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);

    for (LineSegment *lineSegment in self.lines) {
        CGContextSetStrokeColorWithColor(context,
                                         [lineSegment lineColor].CGColor);
        CGContextMoveToPoint(context, lineSegment.start.x, lineSegment.start.y);
        CGContextAddLineToPoint(context, lineSegment.end.x, lineSegment.end.y);
        CGContextStrokePath(context);
    }
}

-(NSMutableArray *)lines {
    if (!_lines) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}


#pragma mark Touches methods


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    CGPoint second = [touch locationInView:self];
    LineSegment *line = [[LineSegment alloc] initWithStart:first
                                                    andEnd:second
                                                  andColor:[self.delegate currentStrokeColor]];

    [self.lines addObject:line];
    [self setNeedsDisplay];
}


@end
