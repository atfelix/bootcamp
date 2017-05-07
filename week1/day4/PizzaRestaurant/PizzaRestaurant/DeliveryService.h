//
//  DeliveryService.h
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pizza;
@class DeliveryCar;

@interface DeliveryService : NSObject

@property (nonatomic) NSMutableArray<NSString *> *allDeliveredPizzas;
@property (nonatomic) DeliveryCar *deliveryCar;

-(void) deliverPizza:(Pizza *)pizza;

@end
