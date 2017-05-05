//
//  main.m
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"
#import "PaymentGateway.h"
#import "AmazonPaymentService.h"
#import "PayPalPaymentService.h"
#import "StripePaymentService.h"
#import "ApplePaymentService.h"

#define LOWER_BOUND 100
#define UPPER_BOUND 1000

int getRandomNumberInRange(int lower, int upper);

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        InputCollector *input = [[InputCollector alloc] init];

        NSArray<NSString *>*paymentMethods = @[
                                                @"PayPal",
                                                @"Stripe",
                                                @"Amazon",
                                                @"ApplePay"
                                              ];

        NSMutableString *outputString = [[NSMutableString alloc] init];

        int randomNumber = getRandomNumberInRange(LOWER_BOUND, UPPER_BOUND);

        [outputString appendString:@"\nThank you for shopping at Acme.com\n"];
        [outputString appendFormat:@"Your total today is $%d.\n", randomNumber];
        [outputString appendString:@"Please select your payment method:\n\n"];

        [paymentMethods enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
            [outputString appendFormat:@"       %lu: %@\n", index + 1, obj];
        }];

        [outputString appendString:@"\n"];

        int index;

        NSString *userInput;

        do {
            userInput = [input inputFromPrompt:outputString];

            if (![InputCollector isValidInteger:userInput]) {
                NSLog(@"Please input valid integer");
                continue;
            }

            index = [userInput intValue] - 1;

            if (index >= paymentMethods.count || index < 0) {
                NSLog(@"Please a number between 1 and %lu", paymentMethods.count);
                continue;
            }
            break;

        } while (1);

        PaymentGateway *paymentGateway = [[PaymentGateway alloc] init];
        id<PaymentDelegate> delegate;

        switch (index) {
            case 0: delegate = [[PayPalPaymentService alloc] init]; break;
            case 1: delegate = [[StripePaymentService alloc] init]; break;
            case 2: delegate = [[AmazonPaymentService alloc] init]; break;
            case 3: delegate = [[ApplePaymentService alloc] init]; break;
            default: break;
        }

        paymentGateway.paymentDelegate = delegate;

        [paymentGateway processPaymentAmount:randomNumber];
    }
    return 0;
}

int getRandomNumberInRange(int lower, int upper) {

    if (upper < lower) {
        return getRandomNumberInRange(upper, lower);
    }

    return lower + arc4random_uniform(upper - lower);
}
