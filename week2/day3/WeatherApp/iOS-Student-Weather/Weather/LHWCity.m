//
//  LHWCity.m
//  Weather
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LHWCity.h"

@implementation LHWCity

-(instancetype)initWithCityName:(NSString *)cityName andImageName:(NSString *)imageName {

    self = [super init];
    if (self) {
        _cityName = cityName;
        _imageName = imageName;

        NSArray<NSString *> *weatherNames = @[
                                                    @"clear-day",
                                                    @"clear-night",
                                                    @"cloudy-night",
                                                    @"cloudy",
                                                    @"default",
                                                    @"fog",
                                                    @"partly-cloudy",
                                                    @"rain",
                                                    @"sleet",
                                                    @"snow",
                                                    @"wind"
        ];
        _weatherName = weatherNames[arc4random_uniform((uint32_t)weatherNames.count)];
    }
    return self;
}

- (instancetype)init {
    return [self initWithCityName:@"default" andImageName:@"noimage"];
}

@end
