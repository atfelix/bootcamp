//
//  LPSDataModel.m
//  PoliceSketch
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPSDataModel.h"

static NSString *basePath = @"/Users/Owner1/Documents/programming/mobile_development/iOS_development/lighthouse/bootcamp/week2/day1/PoliceSketch/iOS-Student-PoliceSketch/Images";

@implementation LPSDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _eyeImages = [[NSMutableArray alloc] init];
//        _noseImages = [[NSMutableArray alloc] init];
//        _mouthImages = [[NSMutableArray alloc] init];
//
//        for (int i = 0; i < 5; i++) {
//            UIImage *eyeImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/eyes_%d.jpg", basePath, i + 1]];
//            UIImage *noseImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/nose_%d.jpg", basePath, i + 1]];
//            UIImage *mouthImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/mouth_%d.jpg", basePath, i + 1]];
//
//            [_eyeImages addObject:eyeImage];
//            [_noseImages addObject:noseImage];
//            [_mouthImages addObject:mouthImage];
//        }
        _eyeImages = @[
                            [UIImage imageNamed:@"eyes_1.jpg"],
                            [UIImage imageNamed:@"eyes_2.jpg"],
                            [UIImage imageNamed:@"eyes_3.jpg"],
                            [UIImage imageNamed:@"eyes_4.jpg"],
                            [UIImage imageNamed:@"eyes_5.jpg"]
                      ];
        _noseImages = @[
                            [UIImage imageNamed:@"nose_1.jpg"],
                            [UIImage imageNamed:@"nose_2.jpg"],
                            [UIImage imageNamed:@"nose_3.jpg"],
                            [UIImage imageNamed:@"nose_4.jpg"],
                            [UIImage imageNamed:@"nose_5.jpg"]
                       ];
        _mouthImages = @[
                            [UIImage imageNamed:@"mouth_1.jpg"],
                            [UIImage imageNamed:@"mouth_2.jpg"],
                            [UIImage imageNamed:@"mouth_3.jpg"],
                            [UIImage imageNamed:@"mouth_4.jpg"],
                            [UIImage imageNamed:@"mouth_5.jpg"]
                       ];

    }
    return self;
}

@end
