//
//  TodoObject.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TodoObject.h"

@implementation TodoObject

-(instancetype)initWithTitle:(NSString *)titleString andDescription:(NSString *)descriptionString andPriorityNumber:(NSInteger)priorityNumber {

    self = [super init];
    if (self) {
        _title = titleString;
        _todoDescription = descriptionString;
        _priorityNumber = priorityNumber;
        _done = NO;
    }
    return self;
}

-(instancetype)init {
    return [self initWithTitle:@"NO TITLE"
                andDescription:@"NO DESCRIPTION"
             andPriorityNumber:-1];
}

@end