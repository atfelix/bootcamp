//
//  Todo+CoreDataProperties.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
}

@dynamic done;
@dynamic dateCreated;
@dynamic deadlineDate;
@dynamic priorityNumber;
@dynamic title;
@dynamic todoDescription;

@end
