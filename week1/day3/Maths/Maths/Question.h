//
//  Question.h
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic) NSString *question;
@property (nonatomic) NSInteger answer;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSInteger leftValue;
@property (nonatomic) NSInteger rightValue;

-(NSTimeInterval) timeToAnswer;
-(void) generateQuestion;

@end
