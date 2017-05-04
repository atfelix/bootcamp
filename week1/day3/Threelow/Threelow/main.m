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

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSLog(@"================================");
        NSLog(@"------------THREELOW------------");
        NSLog(@"================================");


        GameController *gameController = [[GameController alloc] init];

        while (1) {

            NSLog(@"%@", gameController);
            NSLog(@"\nType quit to leave hold menu");

            NSString *userInput = [gameController takeTurn];

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
