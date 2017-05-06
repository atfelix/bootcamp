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

-(instancetype) init {

    self = [super init];
    if (self) {
        NSString *promptPhoneLabelString = @"Enter Label for Phone Number: ";
        NSString *promptPhoneNumberString = @"Enter phone number (###-###-####): ";

        _label = [InputCollector getAndParseStringFromPromptString:promptPhoneLabelString];

        NSString *phoneNumberString = [InputCollector getAndParseStringFromPromptString:promptPhoneNumberString];

        if (![InputCollector isValidPhoneNumber:phoneNumberString]) {
            NSLog(@"INVALID PHONE NUMBER");
            NSLog(@"Phone Number not added");
            return nil;
        }

        _number = phoneNumberString;
    }
    return self;
}

-(BOOL)isEqualTo:(id)other {

    if (other == self) {
        return YES;
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

-(BOOL)labelHasSubstring:(NSString *)string {
    return [self.label rangeOfString:string].location != NSNotFound;
}

-(BOOL)searchForString:(NSString *)string {
    return [self labelHasSubstring:string];
}

-(NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"\nLabel:       %@\nPhonenumber: %@\n", self.label, self.number];
    return desc;
}

@end
