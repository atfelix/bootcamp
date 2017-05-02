//
//  InputCollector.h
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputCollector : NSObject

-(NSString *)inputFromPrompt:(NSString *)promptString;
+(BOOL) isValidEmail:(NSString *)emailInputString;
+(BOOL) isValidInteger:(NSString *) inputString;
+(BOOL) isValidPhoneNumber:(NSString *) inputString;

@end
