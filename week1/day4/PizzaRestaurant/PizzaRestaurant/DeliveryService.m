//
//  DeliveryService.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "DeliveryService.h"

#import "DeliveryCar.h"
#import "Pizza.h"

@implementation DeliveryService

- (instancetype)init {

    self = [super init];
    if (self) {
        _deliveryCar = [[DeliveryCar alloc] init];
        _allDeliveredPizzas = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)deliverPizza:(Pizza *)pizza {
    if (pizza) {
        NSLog(@"Delivery Service: %@", [pizza description]);
        [self.allDeliveredPizzas addObject:[pizza description]];
        [self.deliveryCar deliverPizza:pizza];
    }
}

-(NSString *)description {

    NSMutableString *desc = [[NSMutableString alloc] init];

    [desc appendFormat:@"\n"];

    for (Pizza *pizza in self.allDeliveredPizzas) {
        [desc appendFormat:@"%@\n", [pizza description]];
    }

    return [desc copy];
}

@end
