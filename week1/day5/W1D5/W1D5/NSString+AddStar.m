//
//  NSString+AddStar.m
//  W1D5
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "NSString+AddStar.h"

@implementation NSString (AddStar)

-(NSString *)addStar {
    return [self stringByAppendingString:@"*"];
}

@end
