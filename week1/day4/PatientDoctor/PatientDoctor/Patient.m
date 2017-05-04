//
//  Patient.m
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Patient.h"
#import "Prescription.h"
#import "Appointment.h"

@implementation Patient

-(instancetype)initWithName:(NSString *)name andAge:(NSUInteger)age {

    self = [super init];
    if (self) {
        _name = name;
        _age = age;
        _doctor = nil;
        _prescriptions = [[NSMutableSet alloc] init];
        _appointments = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)makeAppointmentAtDate:(NSDate *)date {

    if (self.doctor == nil) {
        NSLog(@"You can't make an appointment.  You don't have a doctor");
        return;
    }

    [self.appointments addObject:[[Appointment alloc] initWithPatient:self
                                                              andDate:[NSDate date]
                                                andAppointmentManager:nil]];
}

-(void)cancelAppointment {
}

-(void)addPrescriptionsObject:(Prescription *)object {
    [self.prescriptions addObject:object];
}

-(void)takePrescriptions {

    for (Prescription *prescription in self.prescriptions) {
        prescription.numPillsPerDay--;
    }
}

-(void)addDoctor:(Doctor *)doctor {
    self.doctor = doctor;
}

-(NSString *)respondToQuestion:(NSString *)question {
    return [NSString stringWithUTF8String:"YES"];
}

@end
