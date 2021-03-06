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

    
    PizzaSize size = [Pizza getPizzaSizeFromString:sizeString];

    if (size == PIZZA_SIZE_ERROR) {
        NSLog(@"No such pizza size");
        return nil;
    }

    if ([sizeString caseInsensitiveCompare:@"pepperoni"] == NSOrderedSame) {
        toppings = @[@"pepperoni"];
    }

    if ([toppings[0] caseInsensitiveCompare:@"meatlovers"] == NSOrderedSame) {
        toppings = @[@"meatlovers"];
    }

    BOOL shouldMakePizza = [self.delegate kitchen:self
                            shouldMakePizzaOfSize:size
                                      andToppings:toppings];
    BOOL shouldUpgradePizza = [self.delegate kitchenShouldUpgradeOrder:self];

    Pizza *pizzaToMake;
    
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
