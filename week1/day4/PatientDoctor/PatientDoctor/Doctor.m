//
//  Doctor.m
//  PatientDoctor
//
//  Created by atfelix on 2017-05-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"
#import "Prescription.h"

@implementation Doctor

-(void)diagnose:(Patient *)patient {

    NSArray<NSString *> *questions = @[
                                      @"What's your name?",
                                      @"What's your age?",
                                      @"What's wrong?",
                                      @"For how long?",
                                      @"Has this happened before?"
                                     ];

    NSMutableArray<NSString *> *responses = [[NSMutableArray alloc] init];

    for (NSString *question in questions) {
        [responses addObject:[self askQuestion:question
                                     toPatient:patient]];
    }

    [patient addPrescriptionsObject:[Prescription randomPrescription]];

}

-(NSString *) askQuestion:(NSString *) question toPatient:(Patient *)patient{
    return [patient respondToQuestion:question];
}

@end
