//
//  NSString+PigLatinUtility.h
//  PigLatin
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PigLatinUtility)

-(NSString *) stringByPigLatinization;
+(NSString *) convertWordToPigLatin:(NSString *) word;

@end
