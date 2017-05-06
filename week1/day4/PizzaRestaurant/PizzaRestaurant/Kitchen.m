//
//  Kitchen.m
//  PizzaRestaurant
//
//  Created by Steven Masuch on 2014-07-19.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "Kitchen.h"
#import "Pizza.h"

@implementation Kitchen

- (Pizza *)makePizzaWithSize:(NSString *)sizeString toppings:(NSArray *)toppings {

    Pizza *pizzaToMake;
    PizzaSize size;

    if ([sizeString caseInsensitiveCompare:@"small"] == NSOrderedSame) {
        size = PIZZA_SIZE_SMALL;
    }
    else if ([sizeString caseInsensitiveCompare:@"medium"] == NSOrderedSame) {
        size = PIZZA_SIZE_MEDIUM;
    }
    else if ([sizeString caseInsensitiveCompare:@"large"] == NSOrderedSame) {
        size = PIZZA_SIZE_LARGE;
    }
    else if ([sizeString caseInsensitiveCompare:@"pepperoni"] == NSOrderedSame) {
        size = PIZZA_SIZE_LARGE;
        toppings = @[@"pepperoni"];
    }
    else {
        NSLog(@"No such pizza size");
        return nil;
    }

    if ([toppings[0] caseInsensitiveCompare:@"meatlovers"] == NSOrderedSame) {
        toppings = @[@"meatlovers"];
    }

    if (self.delegate == nil) {
        return nil;
    }

    BOOL shouldMakePizza = [self.delegate kitchen:self
                            shouldMakePizzaOfSize:size
                                      andToppings:toppings];
    BOOL shouldUpgradePizza = [self.delegate kitchenShouldUpgradeOrder:self];

    if (shouldUpgradePizza && shouldMakePizza) {
        pizzaToMake = [[Pizza alloc] initWithSize:PIZZA_SIZE_LARGE
                                      andToppings:toppings];
    }
    else if (shouldMakePizza) {
        pizzaToMake = [[Pizza alloc] initWithSize:size
                                      andToppings:toppings];
    }

    if ([self.delegate respondsToSelector:NSSelectorFromString(@"kitchenDidMakePizza:")]) {
        [self.delegate kitchenDidMakePizza:pizzaToMake];
    }
    return pizzaToMake;
}

@end
