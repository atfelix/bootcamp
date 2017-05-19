//
//  TodoManager.h
//  EveryDo
//
//  Created by atfelix on 2017-05-19.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TodoObject;

@interface TodoManager : NSObject

@property (nonatomic) NSMutableArray<NSMutableArray<TodoObject *> *> *todoCollection;

-(instancetype)initWithSectionCapacity:(NSInteger)count;

@end
