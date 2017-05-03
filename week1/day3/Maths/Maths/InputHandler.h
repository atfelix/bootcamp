//
//  InputHandler.h
//  Maths
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputHandler : NSObject

@property (nonatomic, readonly) NSString *userInputString;

+(NSString *) getInputString;
+(NSString *) parseInputString:(NSString *) string;

- (instancetype)initAndGetUserInput;

@end
