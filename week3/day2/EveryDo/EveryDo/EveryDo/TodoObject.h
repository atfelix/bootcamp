//
//  TodoObject.h
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoObject : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *todoDescription;
@property (nonatomic) NSInteger priorityNumber;
@property (nonatomic, assign, getter=isDone) BOOL done;
@property (nonatomic) NSDate *dateCreated;
@property (nonatomic) NSDate *dateFinished;

@end
