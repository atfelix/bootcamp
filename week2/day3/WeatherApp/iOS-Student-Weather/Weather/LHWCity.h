//
//  LHWCity.h
//  Weather
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHWCity : NSObject

@property (nonatomic) NSString *cityName;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *weatherName;

-(instancetype)initWithCityName:(NSString *)cityName andImageName:(NSString *)imageName;

@end
