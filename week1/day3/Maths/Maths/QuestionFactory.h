//
//  QuestionFactory.h
//  Maths
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Question.h"

@interface QuestionFactory : Question {
    NSArray *questionSubclassNames;
}

-(Question *) generateRandomQuestion;

@end
