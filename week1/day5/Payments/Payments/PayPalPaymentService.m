//
//  PayPalPaymentService.m
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PayPalPaymentService.h"

@implementation PayPalPaymentService

-(void)processPaymentAmount:(NSInteger)amount {
    if ([self canProcessPayment]) {
        NSLog(@"Why are you still using PayPal, even we're in shock?");
    }
    else {
        NSLog(@"Sorry, can't process this");
    }
    
}

-(BOOL)canProcessPayment {
    return (arc4random_uniform(2) == 1) ? YES : NO;
}

@end
