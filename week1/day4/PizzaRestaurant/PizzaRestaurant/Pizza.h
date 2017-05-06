//
//  Pizza.h
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PizzaSizeTypes {

    PIZZA_SIZE_SMALL,
    PIZZA_SIZE_MEDIUM,
    PIZZA_SIZE_LARGE

} PizzaSize;

@interface Pizza : NSObject

@property (nonatomic) PizzaSize size;
@property (nonatomic) NSArray<NSString *> *toppings;

-(instancetype) initWithSize:(PizzaSize) size andToppings:(NSArray<NSString *>*) toppings;

+(Pizza *) largePepperoni;
+(Pizza *) meatLoversPizzaWithSize:(PizzaSize) size;

@end
