//
//  AppointmentManager.h
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Appointment;

@interface AppointmentManager : NSObject

@property (nonatomic) NSMutableSet<Appointment *>*appointments;

-(void) addAppointmentsObject:(Appointment *)appointment;
-(void) runAppointments;

@end
