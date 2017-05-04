//
//  Patient.h
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Appointment;
@class Prescription;
@class Doctor;

@interface Patient : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic) NSMutableSet<Prescription *>* prescriptions;
@property (nonatomic, weak) Doctor* doctor;
@property (nonatomic) NSMutableArray<Appointment *>* appointments;

-(instancetype)initWithName:(NSString *)name andAge:(NSUInteger) age;

-(void) makeAppointmentAtDate:(NSDate *)date;
-(void) cancelAppointment;
-(void) addPrescriptionsObject:(Prescription *)object;
-(void) takePrescriptions;
-(void) addDoctor:(Doctor *)doctor;
-(NSString *) respondToQuestion:(NSString *) question;

@end
