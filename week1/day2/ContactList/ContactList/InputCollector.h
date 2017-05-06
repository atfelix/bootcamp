//
//  InputCollector.h
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputCollector : NSObject

+(NSString *)getInputFromPrompt:(NSString *)promptString;
+(NSString *)removeLeadingAndTrailingWhitespaceFrom:(NSString *)string;
+(NSString *)removeConsecutiveSpacesFrom:(NSString *)string;
+(NSString *)getAndParseStringFromPromptString:(NSString *)promptString;
+(NSString *)getAndParseString;
+(BOOL) isValidEmail:(NSString *)emailInputString;
+(BOOL) isValidInteger:(NSString *) inputString;
+(BOOL) isValidPhoneNumber:(NSString *) inputString;

@end
