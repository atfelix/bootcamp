//
//  Contact.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Contact.h"

@interface Contact()

@property (nonatomic, copy) NSMutableArray<PhoneNumber *> *mutableArray;

@end

@implementation Contact

- (instancetype)initWithInputCollector:(InputCollector *)input {

    self = [super init];
    if (self) {
        NSString *promptFullNameString = @"Enter Full Name";
        NSString *promptEmailString = @"Enter email address";

        _fullname = [input inputFromPrompt:promptFullNameString];

        NSString *emailInputString = [input inputFromPrompt:promptEmailString];

        if (![InputCollector isValidEmail:emailInputString]) {
            NSLog(@"Invalid email entered");
            NSLog(@"CONTACT NOT ADDED TO contacts");
            return nil;
        }
        _email = emailInputString;
        _mutableArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray<PhoneNumber *> *)phoneNumbers {
    return [self.mutableArray copy];
}

-(void)addPhoneNumber:(PhoneNumber *)phoneNumber {
    for (PhoneNumber *phone in self.phoneNumbers) {
        if ([phone isEqual:phoneNumber]) {
            NSLog(@"Phone Number is already added");
            return;
        }
    }
    [self.mutableArray addObject:phoneNumber];
}


-(NSString *)description {

    NSMutableString *desc = [NSMutableString stringWithFormat:@"\n\nFull Name: %@\nEmail: %@\n", self.fullname, self.email];

    if (self.phoneNumbers.count != 0) {
        [desc appendString:@"PHONE NUMBERS:\n\n"];
    }

    for (PhoneNumber *phone in self.phoneNumbers) {
        [desc appendFormat:@"Label: %@\nPhone Number:%@\n", phone.label, phone.number];
    }
    return desc;
}

-(BOOL)searchForString:(NSString *)string {
    if ([self.email rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    return NO;
}

-(BOOL)isEqual:(id)object {

    if (self == object) {
        return YES;
    }
    else if (![super isEqual:object]){
        return NO;
    }
    else if (![object isKindOfClass:[Contact class]]) {
        return NO;
    }
    else if (![self.email isEqualToString:[object email]]) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
