//
//  LHWCityViewController.h
//  Weather
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHWCity;

@interface LHWCityViewController : UIViewController

@property (nonatomic) LHWCity *city;

-(instancetype)initWithCity:(LHWCity *) city;

@end
