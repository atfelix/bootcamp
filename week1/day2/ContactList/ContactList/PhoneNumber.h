//
//  PhoneNumber.h
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InputCollector.h"

@interface PhoneNumber : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *number;

-(BOOL) searchForString: (NSString *) string;

@end
