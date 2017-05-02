//
//  InputHandler.m
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "InputHandler.h"

#define MAX_CHARS 255

@implementation InputHandler

+(NSString *)getInputString {
    char inputChars[MAX_CHARS];
    fgets(inputChars, MAX_CHARS, stdin);
    NSString *userInputString = [NSString stringWithCString:inputChars
                                                   encoding:NSUTF8StringEncoding];
    return userInputString;
}

+(NSString *)parseInputString:(NSString *)string {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *parsedInputString = [string stringByTrimmingCharactersInSet:charSet];
    return parsedInputString;
}

- (instancetype)initAndGetUserInput
{
    self = [super init];
    if (self) {
        NSString *string = [InputHandler getInputString];
        _userInputString = [InputHandler parseInputString:string];
    }
    return self;
}

@end
