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
@property (nonatomic) CGFloat lastTimestamp;

@end

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    for (LineSegment *line in self.lines) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [DrawView stroke:path forLine:line];
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.lastTimestamp = [touches.anyObject timestamp];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    CGPoint second = [touch locationInView:self];
    LineSegment *line = [[LineSegment alloc] initWithStart:first
                                                    andEnd:second
                                                  andColor:[self.delegate currentStrokeColor]
                                              andLineWidth:[self calculateVelocityOfTouch:touch]];
    [self.lines addObject:line];
    self.lastTimestamp = [touch timestamp];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.lastTimestamp = 0;
}


#pragma mark Utility Functions


+(void)stroke:(UIBezierPath *)path forLine:(LineSegment *)line {
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinRound;

    path.lineWidth = line.lineWidth;
    [line.lineColor setStroke];

    [path moveToPoint:line.start];
    [path addLineToPoint:line.end];
    [path stroke];
}

+(CGFloat)calculateVelocityFrom:(CGPoint)here to:(CGPoint)there overTime:(CGFloat)time {
    return pow(((there.x - here.x) * (there.x - here.x) + (there.y - here.y) * (there.y - here.y)) / time, 0.2);
}

-(CGFloat)calculateVelocityOfTouch:(UITouch *)touch {
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    CGFloat timeDelta = [touch timestamp] - self.lastTimestamp;

    return [DrawView calculateVelocityFrom:previousLocation to:location overTime:timeDelta];
}


@end
