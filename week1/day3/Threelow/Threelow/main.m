//
//  main.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Die.h"
#import "InputCollector.h"
#import "GameController.h"

#define NUM_CHARS 255
#define NUM_DICE 6

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        InputCollector *inputCollector = [[InputCollector alloc] init];
        GameController *gameController = [[GameController alloc] init];

        while (1) {

            NSLog(@"%@", gameController);

            NSLog(@"============================");
            NSLog(@"Type quit to leave hold menu");

            while (1) {
                NSString *promptString = [NSString stringWithFormat:@"Would you like to toggle any die (1-%d or quit)?", NUM_DICE];
                NSString *userInput = [inputCollector inputFromPrompt:promptString];

                if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
                    break;
                }

                if (![InputCollector isValidInteger:userInput]) {
                    NSLog(@"length: %lu  string: %@", userInput.length, userInput);
                    NSLog(@"Invalid input.  Please try again.");
                    continue;
                }

                int index = [userInput intValue];

                if (index < 1 || index > NUM_DICE) {
                    NSLog(@"Invalid index.  Please try again.");
                    continue;
                }

                [gameController toggleDie:index - 1];
            }

            NSString *userInput = [inputCollector inputFromPrompt:@""];

            if ([userInput caseInsensitiveCompare:@"quit"] == NSOrderedSame) {
                break;
            }
            else if ([userInput caseInsensitiveCompare:@"roll"] == NSOrderedSame) {
                [gameController rollDice];
            }
            else if ([userInput caseInsensitiveCompare:@"reset"] == NSOrderedSame) {
                [gameController resetDice];
            }
        }

    }
    return 0;
}
