//
//  CheeryManager.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "CheeryManager.h"

static CheeryManager *sharedInstance = nil;

@implementation CheeryManager

- (instancetype)init {
    return [CheeryManager sharedInstance];
}

- (instancetype)initSpecial {

    self = [super init];
    if (self) {
        // do nothing
    }
    return self;
}

-(BOOL)kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings {
    return YES;
}

-(BOOL)kitchenShouldUpgradeOrder:(Kitchen *)kitchen {
    return YES;
}

-(void)kitchenDidMakePizza:(id)pizza {
    NSLog(@"I hope you enjoy your pizza");
}

+(CheeryManager *) sharedInstance {

    if (sharedInstance == nil) {
        sharedInstance = [[CheeryManager alloc] initSpecial];
    }

    return sharedInstance;
}

@end
