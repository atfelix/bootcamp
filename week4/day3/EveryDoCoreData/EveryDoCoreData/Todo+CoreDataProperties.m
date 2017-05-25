//
//  Todo+CoreDataProperties.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
}

@dynamic isDone;
@dynamic priorityNumber;
@dynamic title;
@dynamic todoDescription;

@end
