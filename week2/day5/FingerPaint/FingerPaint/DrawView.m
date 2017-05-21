//
//  DrawView.m
//  FingerPaint
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DrawView.h"

#import "LineSegment.h"


@interface DrawView () <UITextViewDelegate>

@property (nonatomic) NSMutableArray<LineSegment *> *lines;
@property (nonatomic) NSMutableArray<UIColor *> *lineColors;
@property (nonatomic) UIBezierPath *currentBezierPath;
@property (nonatomic) CGFloat lastTimestamp;
@property (nonatomic) DrawViewEditingMode editingMode;
@property (nonatomic, assign, getter=isTextViewEditing) BOOL textViewEditing;

@end

@implementation DrawView


-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self registerNotifications];
        _editingMode = DrawViewDrawMode;
    }
    return self;
}

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
    UITouch *touch = touches.anyObject;

    if (self.editingMode == DrawViewDrawMode) {
        self.lastTimestamp = [touch timestamp];
    }
    else if (self.isTextViewEditing) {
        [self endEditing:YES];
        self.textViewEditing ^= YES;
    }
    else if (self.editingMode == DrawViewTextMode) {
        self.textViewEditing ^= YES;

        CGPoint touchLocation = [touch locationInView:self];
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(touchLocation.x,
                                                                            touchLocation.y,
                                                                            100,
                                                                            100)];

        textView.layer.borderColor = [UIColor grayColor].CGColor;
        textView.layer.borderWidth = 0.5;
        textView.delegate = self;

        [self addSubview:textView];
        [textView becomeFirstResponder];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.editingMode == DrawViewDrawMode) {
        [self addTouchToLines:touches.anyObject];
    }
    else if (self.editingMode == DrawViewEraseMode) {
        [self removeLineAtLocation:[touches.anyObject locationInView:self]];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.editingMode == DrawViewDrawMode) {
        self.lastTimestamp = 0;
    }
}


#pragma mark Utility Functions


-(void)addTouchToLines:(UITouch *)touch{
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


-(void)removeLineAtLocation:(CGPoint)location {
    NSMutableArray *intersectingLineIndices = [[NSMutableArray alloc] init];

    for (int i = (int)self.lines.count - 1; i >= 0; i--) {
        if ([DrawView location:location intersectsLineSegment:self.lines[i]]) {
            [intersectingLineIndices addObject:@(i)];
        }
    }

    for (NSNumber *i in intersectingLineIndices) {
        [self.lines removeObjectAtIndex:[i unsignedIntegerValue]];
    }
    [self setNeedsDisplay];
}

+(BOOL)location:(CGPoint)location intersectsLineSegment:(LineSegment *)line {
    CGFloat currentX = line.start.x, currentY = line.start.y;

    CGFloat deltaX, deltaY;
    CGFloat lambda = 0;

    if (fabs(line.start.x - line.start.y) < 0.00001){
        deltaX = 0;
        deltaY = 0.05;
    }
    else {
        CGFloat slope = (line.start.y - line.end.y) / (line.start.x - line.end.x);
        deltaX = 0.05;
        deltaY = slope * 0.05;
    }

    while (lambda <= 1) {
        if ([DrawView distanceFrom:location to:CGPointMake(currentX, currentY)] < 30.0) {
            return YES;
        }
        lambda += 0.5;
        currentX += lambda * deltaX;
        currentY += lambda * deltaY;
    }
    return NO;
}

+(CGFloat)distanceFrom:(CGPoint)here to:(CGPoint)there {
    return sqrt((here.x - there.x) * (here.x - there.x) + (here.y - there.y) * (here.y - there.y));
}


+(void)stroke:(UIBezierPath *)path forLine:(LineSegment *)line {
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;

    path.lineWidth = line.lineWidth;
    [line.lineColor setStroke];

    [path moveToPoint:line.start];
    [path addLineToPoint:line.end];
    [path stroke];
}

+(CGFloat)calculateVelocityFrom:(CGPoint)here to:(CGPoint)there overTime:(CGFloat)time {
    return (fabs(there.x - here.x) + fabs(there.y - here.y)) / 20.0;
}

-(CGFloat)calculateVelocityOfTouch:(UITouch *)touch {
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    CGFloat timeDelta = [touch timestamp] - self.lastTimestamp;

    return [DrawView calculateVelocityFrom:previousLocation to:location overTime:timeDelta];
}


#pragma mark Notification Center logic


-(void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeEditingMode:)
                                                 name:@"ChangeEditingModeNotification"
                                               object:self.delegate];
}

-(void)changeEditingMode:(NSNotification *)notification {
    self.editingMode = (DrawViewEditingMode)[notification.userInfo[@"SegmentedControlObjectSelectedIndex"] intValue];
}


#pragma mark UITextViewDelegate methods


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    textView.textColor = [self.delegate currentStrokeColor];
    return YES;
}


@end
