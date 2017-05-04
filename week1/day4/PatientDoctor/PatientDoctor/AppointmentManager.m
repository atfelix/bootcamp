//
//  AppointmentManager.m
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Appointment.h"
#import "AppointmentManager.h"

@implementation AppointmentManager

- (instancetype)init {

    self = [super init];
    if (self) {
        _appointments = [[NSMutableSet alloc] init];
    }
    return self;
}

-(NSMutableArray<Appointment *> *)appointments {
    return [_appointments copy];
}

-(void)addAppointmentsObject:(Appointment *)appointment {
    [self.appointments addObject:appointment];
}

-(void)runAppointments {
    for (Appointment *appointment in self.appointments) {
        [appointment runAppointment];
    }
}

@end
