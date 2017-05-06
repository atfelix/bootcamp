//
//  Printer.h
//  WordPrinter
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Printer;

@protocol PrinterDelegate <NSObject>

-(int) printer:(Printer *) printer numberOfTimesToPrint:(NSString *) word;
-(BOOL) shouldPrintStarBeforeAndAfterWord;

@optional

-(BOOL) shouldPrintUppercase;

@end

@interface Printer : NSObject

@property (nonatomic) id<PrinterDelegate> delegate;

-(void) printWord:(NSString *) word;

@end
