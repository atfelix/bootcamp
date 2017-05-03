//
//  ContactList.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Contact.h"
#import "ContactList.h"

@interface ContactList()

@property (nonatomic, copy) NSMutableArray<Contact *> *mutableArray;

@end

@implementation ContactList

- (instancetype)init {

    self = [super init];
    if (self) {
        _mutableArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)contacts {
    return [self.mutableArray copy];
}

-(void)addContact:(Contact *)newContact {
    for (Contact* contact in self.mutableArray) {
        if ([newContact isEqualTo:contact]) {
            NSLog(@"Contact already in contacts list");
            return;
        }
    }
    [self.mutableArray addObject:newContact];
}

-(NSArray<Contact *> *)queryItemsMatchingString:(NSString *)string {
    NSMutableArray <Contact *> *matches = [[NSMutableArray alloc] init];

    for (Contact *contact in self.contacts) {
        if ([contact searchForString:string]) {
            [matches addObject:contact];
        }
    }
    return [matches copy];
}

-(NSString *)description {
    return [self.mutableArray description];
}

@end
