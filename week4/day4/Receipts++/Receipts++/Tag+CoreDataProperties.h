//
//  Tag+CoreDataProperties.h
//  Receipts++
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Tag+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tagName;
@property (nullable, nonatomic, retain) NSSet<Receipt *> *receipts;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addReceiptsObject:(Receipt *)value;
- (void)removeReceiptsObject:(Receipt *)value;
- (void)addReceipts:(NSSet<Receipt *> *)values;
- (void)removeReceipts:(NSSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END
