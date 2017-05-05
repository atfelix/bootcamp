//
//  PaymentGateway.h
//  Payments
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PaymentDelegate <NSObject>

-(void) processPaymentAmount:(NSInteger)amount;
-(BOOL) canProcessPayment;

@end

@interface PaymentGateway : NSObject

@property (nonatomic, weak) id<PaymentDelegate> paymentDelegate;

-(void) processPaymentAmount:(NSInteger)amount;

@end
