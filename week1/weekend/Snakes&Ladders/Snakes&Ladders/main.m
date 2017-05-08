//
//  main.m
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"
#import "Player.h"
#import "PlayerManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        PlayerManager *playerManager = [[PlayerManager alloc] init];

        NSLog(@"WELCOME TO SNAKES AND LADDERS");

        [playerManager createPlayers:[PlayerManager getNumberOfPlayers]];

        NSLog(@"Please type \"roll\" or \"r\"");

        while (1) {

            NSString *userInput = [InputCollector getAndParseStringFromPromptString:@""];

            if (userInput && ([userInput caseInsensitiveCompare:@"roll"] == NSOrderedSame)) {
                [playerManager roll];
            }
            else if (userInput && ([userInput caseInsensitiveCompare:@"r"] == NSOrderedSame)) {
                [playerManager roll];
            }
            else if (userInput && ([userInput caseInsensitiveCompare:@"output"] == NSOrderedSame)) {
                [playerManager output];
            }
        }
    }
    return 0;
}
