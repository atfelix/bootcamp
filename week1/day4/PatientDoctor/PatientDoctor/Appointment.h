//
//  Appointment.h
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppointmentManager;
@class Patient;

@interface Appointment : NSObject

@property (atomic, weak) Patient *patient;
@property (atomic) NSDate *dateOfAppointment;
@property (atomic, weak) AppointmentManager* appointmentManager;

-(instancetype)initWithPatient:(Patient *)patient andDate:(NSDate *)date andAppointmentManager:(AppointmentManager *)appointmentManager;

-(void) runAppointment;

@end
