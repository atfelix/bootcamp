//
//  Doctor.h
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Patient;
@class InputCollector;

@interface Doctor : NSObject

@property (nonatomic) NSMutableArray<Patient *>* patients;
@property (nonatomic) InputCollector *input;

-(void) diagnose:(Patient *)patient;

@end
