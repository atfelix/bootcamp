//
//  Contact.h
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"
#import "PhoneNumber.h"

@interface Contact : NSObject

@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, readonly) NSArray <PhoneNumber *> *phoneNumbers;

-(instancetype)initWithInputCollector:(InputCollector *) in;
-(BOOL) searchForString:(NSString *)string;
-(void) addPhoneNumber:(PhoneNumber *) phoneNumber;

@end
