//
//  ApplePaymentService.m
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ApplePaymentService.h"

@implementation ApplePaymentService

-(BOOL)canProcessPayment {
    return (arc4random_uniform(2) == 1) ? YES : NO;
}

-(void)processPaymentAmount:(NSInteger)amount {
    if ([self canProcessPayment]) {
        NSLog(@"Apple Pay Service: %ld", amount);
    }
    else {
        NSLog(@"Sorry, can't process this");
    }
}

@end
