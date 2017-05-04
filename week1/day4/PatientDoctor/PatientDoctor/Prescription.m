//
//  Prescription.m
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Prescription.h"

#define MAX_DAYS 7
#define MAX_PILLS_PER_DAY 5

@implementation Prescription

-(instancetype)initWithPrescriptionName:(NSString *)name perDay:(NSUInteger)numPillsPerDay totalDuration:(NSUInteger)length andSideEffects:(NSArray<NSString *> *)sideEffects {

    self = [super init];
    if (self) {
        _prescriptionName = name;
        _numPillsPerDay = numPillsPerDay;
        _lengthOfPrescription = length;
        _sideEffects = sideEffects;
    }
    return self;
}

+(Prescription *)randomPrescription {

    NSUInteger nDays = arc4random_uniform(MAX_DAYS);
    NSUInteger nPills = arc4random_uniform(MAX_PILLS_PER_DAY);

    return [[Prescription alloc] initWithPrescriptionName:nil
                                                   perDay:nDays
                                            totalDuration:nPills
                                           andSideEffects:nil];
}

@end
