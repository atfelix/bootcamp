//
//  Chef.m
//  Foodtruck
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Chef.h"

@implementation Chef

-(double)foodTruck:(FoodTruck *)truck priceForFood:(NSString *)food {
    return 0.23 * food.length;
}

@end
