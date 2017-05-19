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

-(instancetype)initWithSections:(NSArray *)sectionHeaders;

-(NSInteger)numberOfSections;
-(NSInteger)numberOfElementsInSection:(NSInteger)section;
-(NSInteger)sectionCount:(NSInteger)section;
-(NSString *)getSectionHeaderFromSection:(NSInteger)section;

-(TodoObject *)todoObjectAtIndexPath:(NSIndexPath *)indexPath;

-(void)sortByPriority;
-(void)sortByDeadline;

-(void)addTodoObject:(TodoObject *)todo;
-(void)removeTodoObjectAtIndexPaths:(NSIndexPath *)indexPath;
-(void)moveTodoObjectFromIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
-(void)markTodoObjectAsCompleteAtIndexPath:(NSIndexPath *)indexPath;

@end
