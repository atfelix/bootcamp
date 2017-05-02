//
//  ContactList.h
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactList : NSObject

@property (nonatomic, readonly) NSArray *contacts;

-(void) addContact: (Contact *) newContact;

@end
