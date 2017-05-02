//
//  main.m
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdditionQuestion.h"
#import "InputHandler.h"
#import "ScoreKeeper.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        ScoreKeeper *scoreKeeper = [[ScoreKeeper alloc] init];

        NSLog(@"MATHS!");
        
        while (1) {

            AdditionQuestion *randomQuestion = [[AdditionQuestion alloc] init];
            NSLog(@"%@", randomQuestion.question);

            // Using class functions
            //
            // NSString *userInputString = [InputHandler getInputString];
            // NSString *parsedInputString = [InputHandler parseInputString:userInputString];

            // Using instance methods

            InputHandler *in = [[InputHandler alloc] initAndGetUserInput];

            BOOL gameOn = [in.userInputString isEqualToString:@"quit"];

            if (gameOn) {
                break;
            }

            if (randomQuestion.answer == [in.userInputString integerValue]) {
                NSLog(@"Right!");
                scoreKeeper.numCorrectAnswers++;
            }
            else {
                NSLog(@"Wrong!");
            }

            scoreKeeper.numQuestions++;

            NSLog(@"score: %d right, %d wrong ---- %.0f%%",
                  scoreKeeper.numCorrectAnswers,
                  scoreKeeper.numQuestions - scoreKeeper.numCorrectAnswers,
                  scoreKeeper.getPercentageCorrect);
        }
    }
    return 0;
}
