//
//  Appointment.m
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Appointment.h"
#import "AppointmentManager.h"

@implementation Appointment

-(instancetype)initWithPatient:(Patient *)patient andDate:(NSDate *)date andAppointmentManager:(AppointmentManager *)appointmentManager {

    self = [super init];
    if (self) {
        _patient = patient;
        _dateOfAppointment = date;
        _appointmentManager = appointmentManager;
    }
    return self;
}

-(void)runAppointment {
    [self.appointmentManager.appointments removeObject:self];
}

@end
