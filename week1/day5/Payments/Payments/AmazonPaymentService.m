//
//  AmazonPaymentService.m
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "AmazonPaymentService.h"

@implementation AmazonPaymentService

-(void)processPaymentAmount:(NSInteger)amount {
    if ([self canProcessPayment]) {
        NSLog(@"Welcome the jungle.");
    }
    else {
        NSLog(@"Sorry, can't process this");
    }
}

-(BOOL)canProcessPayment {
    return (arc4random_uniform(2) == 1) ? YES : NO;
}

@end
