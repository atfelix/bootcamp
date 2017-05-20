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
@property (nonatomic) NSMutableArray *lineColors;
@property (nonatomic) UIBezierPath *currentBezierPath;

@end

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    for (LineSegment *line in self.lines) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [self stroke:path forLine:line];
    }
}

-(NSMutableArray *)lines {
    if (!_lines) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}

-(NSMutableArray *)lineColors {
    if (!_lineColors) {
        _lineColors = [[NSMutableArray alloc] init];
    }
    return _lineColors;
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


#pragma mark Utility Functions

-(void)stroke:(UIBezierPath *)path forLine:(LineSegment *)line {
    path.lineWidth = 10.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [line.lineColor setStroke];
    [path moveToPoint:line.start];
    [path addLineToPoint:line.end];
    [path stroke];
}


@end
