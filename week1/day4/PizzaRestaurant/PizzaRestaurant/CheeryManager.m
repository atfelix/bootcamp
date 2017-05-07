//
//  CheeryManager.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "CheeryManager.h"

#import "DeliveryService.h"

static CheeryManager *sharedInstance = nil;

@implementation CheeryManager

-(BOOL)kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings {
    return YES;
}

-(BOOL)kitchenShouldUpgradeOrder:(Kitchen *)kitchen {
    return YES;
}

-(void)kitchenDidMakePizza:(id)pizza {
    [self.deliveryService deliverPizza:pizza];
}

+(CheeryManager *) sharedManager {

    if (sharedInstance == nil) {
        sharedInstance = [[CheeryManager alloc] init];
    }

    return sharedInstance;
}

@end
