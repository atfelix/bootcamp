//
//  Prescription.h
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prescription : NSObject

@property (nonatomic) NSString *prescriptionName;
@property (nonatomic) NSUInteger numPillsPerDay;
@property (nonatomic) NSUInteger lengthOfPrescription;
@property (nonatomic, readonly) NSArray<NSString *> *sideEffects;

-(instancetype)initWithPrescriptionName: (NSString *) name perDay:(NSUInteger) numPillsPerDay totalDuration:(NSUInteger) length andSideEffects: (NSArray<NSString *>*) sideEffects;

+(Prescription *) randomPrescription;

@end
