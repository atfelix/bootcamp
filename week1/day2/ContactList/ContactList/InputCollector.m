//
//  InputCollector.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "InputCollector.h"

#define MAX_CHARS 255

@implementation InputCollector

+(NSString *)getInputFromPrompt:(NSString *)promptString {

    char inputChars[MAX_CHARS];

    NSLog(@"%@", promptString);
    fgets(inputChars, MAX_CHARS, stdin);

    return [NSString stringWithCString:inputChars
                              encoding:NSUTF8StringEncoding];
}

+(NSString *)removeLeadingAndTrailingWhitespaceFrom:(NSString *)string {

    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    string = [string stringByTrimmingCharactersInSet:charSet];

    return string;
}

+(NSString *)removeConsecutiveSpacesFrom:(NSString *)string {

    if (string.length == 0) {
        return nil;
    }

    return [string stringByReplacingOccurrencesOfString:@"[ ]+"
                                             withString:@" "
                                                options:NSRegularExpressionSearch
                                                  range:NSMakeRange(0, string.length - 1)];

}

+(NSString *)getAndParseStringFromPromptString:(NSString *)promptString {

    NSString *input = [InputCollector getInputFromPrompt:promptString];
    input = [InputCollector removeLeadingAndTrailingWhitespaceFrom:input];
    input = [InputCollector removeConsecutiveSpacesFrom:input];

    return input;
}

+(NSString *)getAndParseString {
    return [InputCollector getAndParseStringFromPromptString:@""];
}

+(BOOL) isValidEmail:(NSString *) emailInputString {
    return [InputCollector isString:emailInputString
              aMatchForRegexPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]"];
}

+(BOOL) isValidInteger:(NSString *) inputString {
    return [InputCollector isString:inputString
              aMatchForRegexPattern:@"^\\d+$"];
}

+(BOOL)isValidPhoneNumber:(NSString *)inputString {
    return [InputCollector isString:inputString
              aMatchForRegexPattern:@"^[0-9]{3}-[0-9]{3}-[0-9]{4}$"];
}

+(BOOL)isString:(NSString *)string aMatchForRegexPattern:(NSString *)pattern {

    if (string.length == 0) {
        return NO;
    }

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:nil];

    NSUInteger numMatches = [regex numberOfMatchesInString:string
                                                   options:0
                                                     range:NSMakeRange(0, string.length)];

    return numMatches == 1;
}

@end
