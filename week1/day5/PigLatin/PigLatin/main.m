//
//  main.m
//  PigLatin
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"
#import "NSString+PigLatinUtility.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *input = [InputCollector getAndParseStringFromPromptString:@""];

        NSLog(@"%@", [input stringByPigLatinization]);

    }
    return 0;
}
