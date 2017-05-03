//
//  ScoreKeeper.h
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreKeeper : NSObject

@property (nonatomic) int numQuestions;
@property (nonatomic) int numCorrectAnswers;

-(float) getPercentageCorrect;

@end
