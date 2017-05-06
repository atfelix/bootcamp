//
//  KitchenDelegate.h
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#ifndef KitchenDelegate_h
#define KitchenDelegate_h

#import "Pizza.h"

@class Kitchen;
@class Pizza;

@protocol KitchenDelegate <NSObject>

@required

-(BOOL) kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings;
-(BOOL) kitchenShouldUpgradeOrder:(Kitchen *)kitchen;

@optional

-(void) kitchenDidMakePizza:(Pizza *)pizza;

+(id) sharedManager;

@end

#endif /* KitchenDelegate_h */
