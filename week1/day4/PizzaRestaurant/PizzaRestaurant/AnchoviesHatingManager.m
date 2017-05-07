//
//  AnchoviesHatingManager.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "AnchoviesHatingManager.h"

#import "DeliveryService.h"

static AnchoviesHatingManager *sharedInstance = nil;

@interface AnchoviesHatingManager()

@end

@implementation AnchoviesHatingManager

-(BOOL)kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings {
    return ![toppings containsObject:@"anchovies"];
}

-(BOOL)kitchenShouldUpgradeOrder:(Kitchen *)kitchen {
    return NO;
}

+(AnchoviesHatingManager *) sharedManager {

    if (sharedInstance == nil) {
        sharedInstance = [[AnchoviesHatingManager alloc] init];
    }

    return sharedInstance;
}

@end
