//
//  Person+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by atfelix on 2017-05-24.
//  Copyright © 2017 Adam Felix. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic age;
@dynamic image;

@end
