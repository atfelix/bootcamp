//
//  Printer.m
//  WordPrinter
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Printer.h"

@implementation Printer

-(void) printWord:(NSString *)word {

    if ([self.delegate respondsToSelector:@selector(shouldPrintUppercase)]) {
        if ([self.delegate shouldPrintUppercase]) {
            word = [NSString stringWithFormat:@"%@", [word uppercaseString]];
        }
    }

    NSString *desc;

    if ([self.delegate shouldPrintStarBeforeAndAfterWord]) {
        desc = [NSString stringWithFormat:@"✮%@✮", word];
    }
    else {
        desc = [NSString stringWithFormat:@"%@", word];
    }

    for (int i = 0; i < [self.delegate printer:self numberOfTimesToPrint:word]; i++) {
        NSLog(@"%@", desc);
    }
}

@end
