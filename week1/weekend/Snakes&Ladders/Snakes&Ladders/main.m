//
//  main.m
//  Snakes&Ladders
//
//  Created by atfelix on 2017-05-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"
#import "PlayerManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        PlayerManager *playerManager = [[PlayerManager alloc] init];

        NSLog(@"WELCOME TO SNAKES AND LADDERS");

        while (1) {
            [playerManager playGame];
        }
    }
    return 0;
}
