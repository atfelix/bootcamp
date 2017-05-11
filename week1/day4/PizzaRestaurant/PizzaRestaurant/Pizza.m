//
//  Pizza.m
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Pizza.h"

@implementation Pizza

-(instancetype)initWithSize:(PizzaSize)size andToppings:(NSArray<NSString *> *)toppings {

    toppings = [Pizza makeToppingsLowercase:toppings];

    self = [super init];
    if (self) {
        _size  = size;
        _toppings = [[NSMutableArray alloc] init];
        if ([toppings[0] caseInsensitiveCompare:@"meatlovers"] == NSOrderedSame) {
            _toppings = [@[@"sausage", @"bacon", @"ham", @"goat", @"duck"] mutableCopy];
        }
        else {
            _toppings = [toppings mutableCopy];
        }
    }
    return self;
}

-(NSString *)description {
    NSArray<NSString *> *sizeNames = @[@"Small", @"Medium", @"Large"];
    NSMutableString *desc = [[NSMutableString alloc] init];

    [desc appendString:sizeNames[self.size]];

    for (NSString *topping in self.toppings) {
        [desc appendFormat:@" %@", topping];
    }

    return [desc copy];
}

+(NSArray *) makeToppingsLowercase:(NSArray *) toppings {
    NSMutableArray *newToppings = [[NSMutableArray alloc] init];

    for (NSString *topping in toppings) {
        [newToppings addObject:[topping lowercaseString]];
    }

    return newToppings;
}

+(Pizza *)largePepperoni {
    return [[self alloc] initWithSize:PIZZA_SIZE_LARGE
                           andToppings:@[@"pepperoni"]];
}

+(Pizza *)meatLoversPizzaWithSize:(PizzaSize)size {
    return [[Pizza alloc] initWithSize:size
                           andToppings:@[@"meatlovers"]];
}

+(PizzaSize)getPizzaSizeFromString:(NSString *)sizeString {

    PizzaSize size = PIZZA_SIZE_ERROR;

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
    }

    return size;
}

@end
