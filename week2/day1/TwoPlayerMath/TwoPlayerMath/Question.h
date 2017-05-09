//
//  Question.h
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, assign) NSUInteger leftValue;
@property (nonatomic, assign) NSUInteger rightValue;
@property (nonatomic, assign) unichar operatorChar;
@property (nonatomic, assign) NSInteger answer;

@end
