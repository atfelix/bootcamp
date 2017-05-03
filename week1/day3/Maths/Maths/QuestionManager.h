//
//  QuestionManager.h
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface QuestionManager : NSObject

@property (nonatomic, copy) NSMutableArray<Question *> *questions;

-(void) addQuestion: (Question *) question;
-(NSString *) timeOutput;

@end
