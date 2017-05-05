//
//  StripePaymentService.m
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StripePaymentService.h"

@implementation StripePaymentService

-(void)processPaymentAmount:(NSInteger)amount {
    if ([self canProcessPayment]) {
        NSLog(@"You swipe, we Stripe.");
    }
    else {
        NSLog(@"Sorry, can't process this");
    }
}

-(BOOL)canProcessPayment {
    return (arc4random_uniform(2) == 1) ? YES : NO;
}

@end
