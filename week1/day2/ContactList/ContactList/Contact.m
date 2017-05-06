//
//  Contact.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Contact.h"

@class PhoneNumber;

@interface Contact()

@property (nonatomic, copy) NSMutableArray<PhoneNumber *> *mutableArray;

@end

@implementation Contact

- (instancetype)init {

    self = [super init];
    if (self) {
        NSString *promptFullNameString = @"Enter Full Name";
        NSString *promptEmailString = @"Enter email address";

        _fullname = [InputCollector getAndParseStringFromPromptString:promptFullNameString];

        NSString *emailInputString = [InputCollector getAndParseStringFromPromptString:promptEmailString];

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
        if ([phone isEqualTo:phoneNumber]) {
            NSLog(@"Phone Number is already added");
            return;
        }
    }
    [self.mutableArray addObject:phoneNumber];
}

-(NSString *)description {

    NSMutableString *desc = [NSMutableString stringWithFormat:@"\n\nFull Name: %@\nEmail: %@\n", self.fullname, self.email];

    if (self.phoneNumbers.count != 0) {
        [desc appendString:@"PHONE NUMBERS:\n"];
    }

    for (PhoneNumber *phone in self.phoneNumbers) {
        [desc appendFormat:@"%@", phone];
    }
    return desc;
}

-(BOOL)searchForString:(NSString *)string {
    if ([self.fullname rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    if ([self.email rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    for (PhoneNumber *phonenumber in self.phoneNumbers) {
        if ([phonenumber searchForString:string]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isEqualTo:(id)object {

    if (self == object) {
        return YES;
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
