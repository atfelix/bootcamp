//
//  AnchoviesHatingManager.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "AnchoviesHatingManager.h"

static AnchoviesHatingManager *sharedInstance = nil;

@interface AnchoviesHatingManager()

@property (nonatomic) id instance;

@end

@implementation AnchoviesHatingManager

- (instancetype)init {
    return [AnchoviesHatingManager sharedInstance];
}

- (instancetype)initSpecial {

    self = [super init];
    if (self) {
        // do nothing
    }
    return self;
}

-(BOOL)kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings {
    return ![toppings containsObject:@"anchovies"];
}

-(BOOL)kitchenShouldUpgradeOrder:(Kitchen *)kitchen {
    return NO;
}

+(AnchoviesHatingManager *) sharedInstance {

    if (sharedInstance == nil) {
        sharedInstance = [[AnchoviesHatingManager alloc] initSpecial];
    }

    return sharedInstance;
}

@end
