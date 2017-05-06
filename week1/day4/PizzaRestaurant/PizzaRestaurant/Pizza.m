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
        if ([toppings[0] caseInsensitiveCompare:@"meatlovers"] == NSOrderedSame) {
            _toppings = @[@"sausage", @"bacon", @"ham", @"goat", @"duck"];
        }
        else {
            _toppings = toppings;
        }
    }
    return self;
}

-(NSString *)description {
    NSArray<NSString *> *sizeNames = @[@"Small", @"Medium", @"Large"];
    NSMutableString *desc = [[NSMutableString alloc] init];

    [desc appendString:@"One "];

    [desc appendString:sizeNames[self.size]];

    for (NSString *topping in self.toppings) {
        [desc appendFormat:@" %@", topping];
    }

    [desc appendString:@" pizza coming up"];

    return desc;
}

+(NSArray *) makeToppingsLowercase:(NSArray *) toppings {
    NSMutableArray *newToppings = [[NSMutableArray alloc] init];

    for (NSString *topping in toppings) {
        [newToppings addObject:[topping lowercaseString]];
    }

    return newToppings;
}

+(Pizza *)largePepperoni {
    return [[Pizza alloc] initWithSize:PIZZA_SIZE_LARGE
                           andToppings:@[@"pepperoni"]];
}

+(Pizza *)meatLoversPizzaWithSize:(PizzaSize)size {
    return [[Pizza alloc] initWithSize:size
                           andToppings:@[@"meatlovers"]];
}

@end
