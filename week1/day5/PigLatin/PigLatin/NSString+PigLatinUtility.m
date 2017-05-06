//
//  NSString+PigLatinUtility.m
//  PigLatin
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "NSString+PigLatinUtility.h"

@implementation NSString (PigLatinUtility)

-(NSString *)stringByPigLatinization {

    NSArray *tokens = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSMutableString *string = [[NSMutableString alloc] init];

    for (NSString *token in tokens) {
        [string appendFormat:@"%@ ", [NSString convertWordToPigLatin:token]];
    }
    return string;
}

+(NSString *) convertWordToPigLatin:(NSString *) word {

    NSCharacterSet *vowels = [NSCharacterSet characterSetWithCharactersInString:@"aeiouAEIOU"];
    NSScanner *scanner = [NSScanner scannerWithString:word];
    NSString *firstPart;

    if (![scanner scanUpToCharactersFromSet:vowels
                                 intoString:&firstPart]) {
        firstPart = @"";
    }

    NSString *pigLatinWord = [word substringWithRange:NSMakeRange(firstPart.length,
                                                                  word.length - firstPart.length)];
    return [pigLatinWord stringByAppendingFormat:@"%@ay",firstPart];
}

@end
