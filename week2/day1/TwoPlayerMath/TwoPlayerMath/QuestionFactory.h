//
//  QuestionFactory.h
//  TwoPlayerMath
//
//  Created by atfelix on 2017-05-09.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface QuestionFactory : NSObject

+(Question *)generateQuestion;

@end
