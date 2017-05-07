//
//  CheeryManager.h
//  PizzaRestaurant
//
//  Created by atfelix on 2017-05-05.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KitchenDelegate.h"

@class DeliveryService;

@interface CheeryManager : NSObject <KitchenDelegate>

@property (nonatomic) DeliveryService *deliveryService;

+(CheeryManager *) sharedManager;

@end
