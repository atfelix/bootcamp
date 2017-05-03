//
//  main.m
//  Threelow
//
//  Created by atfelix on 2017-05-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Die.h"

#define NUM_DICE 6

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSMutableArray<Die *> *dice = [[NSMutableArray alloc] init];

        for (int i = 0; i < NUM_DICE; i++) {
            Die *die = [[Die alloc] init];
            [die rollDie];
            [dice addObject:die];
        }

        NSLog(@"%@ %@ %@ %@ %@ %@", dice[0], dice[1], dice[2], dice[3], dice[4], dice[5]);

        while (0) {

        }

    }
    return 0;
}
