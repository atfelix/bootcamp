//
//  PhoneNumber.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "InputCollector.h"
#import "PhoneNumber.h"

@implementation PhoneNumber

-(instancetype) initWithInputCollector: (InputCollector *)input {

    self = [super init];
    if (self) {
        NSString *promptPhoneLabelString = @"Enter Label for Phone Number: ";
        NSString *promptPhoneNumberString = @"Enter phone number (###-###-####): ";

        _label = [input inputFromPrompt:promptPhoneLabelString];

        NSString *phoneNumberString = [input inputFromPrompt:promptPhoneNumberString];

        if (![InputCollector isValidPhoneNumber:phoneNumberString]) {
            NSLog(@"INVALID PHONE NUMBER");
            NSLog(@"Phone Number not added");
            return nil;
        }

        _number = phoneNumberString;
    }
    return self;
}

- (BOOL)isEqual:(id)other {

    if (other == self) {
        return YES;
    }
    else if (![super isEqual:other]) {
        return NO;
    }
    else if (![other isKindOfClass:[PhoneNumber class]]) {
        return NO;
    }
    else if (![self.number isEqualToString:[other number]]) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
