//
//  Todo+CoreDataProperties.h
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Todo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest;

@property (nonatomic) BOOL isDone;
@property (nonatomic) int16_t priorityNumber;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *todoDescription;

@end

NS_ASSUME_NONNULL_END
