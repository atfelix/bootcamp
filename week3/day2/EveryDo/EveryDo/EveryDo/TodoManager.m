//
//  TodoManager.m
//  EveryDo
//
//  Created by atfelix on 2017-05-19.
//  Copyright © 2017 Adam Felix. All rights reserved.
//


#import "TodoManager.h"

@import UIKit;

#import "TodoObject.h"

@interface TodoManager ()

@property NSArray<NSString *> *sectionHeaders;

@end

@implementation TodoManager

-(instancetype)initWithSections:(NSArray *)sectionHeaders {

    self = [super init];
    if (self) {
        _sectionHeaders = sectionHeaders;
        _todoCollection = [[NSMutableArray alloc] init];
        [self initSections:sectionHeaders.count];
    }
    return self;
}


-(NSInteger)numberOfSections {
    return self.todoCollection.count;
}

-(NSInteger)numberOfElementsInSection:(NSInteger)section {
    return [self getSection:section].count;
}

-(TodoObject *)todoObjectAtIndexPath:(NSIndexPath *)indexPath {
    return [self getSection:indexPath.section][indexPath.row];
}

-(void)addTodoObject:(TodoObject *)todo {
    [[self getSection:0] insertObject:todo atIndex:0];
}

-(void)removeTodoObjectAtIndexPaths:(NSIndexPath *)indexPath {
    [[self getSection:indexPath.section] removeObjectAtIndex:indexPath.row];
}

-(void)moveTodoObjectFromIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    TodoObject *todo = [self todoObjectAtIndexPath:sourceIndexPath];
    [self removeTodoObjectAtIndexPaths:sourceIndexPath];
    [self addTodoObject:todo atIndexPath:destinationIndexPath];
}

-(void)markTodoObjectAsCompleteAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= [self numberOfSections] - 1) {
        return;
    }

    TodoObject *todo = [self todoObjectAtIndexPath:indexPath];
    todo.done = YES;

    [self removeTodoObjectAtIndexPaths:indexPath];
    [[self getCompletedTasksSection] insertObject:todo
                                          atIndex:0];
}

-(NSString *)getSectionHeaderFromSection:(NSInteger)section {
    return self.sectionHeaders[section];
}

-(NSInteger)sectionCount:(NSInteger)section {
    return [self getSection:section].count;
}

-(void)sortByPriority {
    for (NSMutableArray *array in self.todoCollection) {
        [array sortUsingComparator:^NSComparisonResult(TodoObject *a, TodoObject *b) {
            return (NSComparisonResult)((a.priorityNumber < b.priorityNumber)
                                        - (b.priorityNumber < a.priorityNumber));
        }];
    }
}

-(void)sortByDeadline {
    for (NSMutableArray *array in self.todoCollection) {
        [array sortUsingComparator:^NSComparisonResult(TodoObject *a, TodoObject *b) {
            return [a.deadlineDate compare:b.deadlineDate];
        }];
    }
}


#pragma mark - Helper Functions


-(void) initSections:(NSInteger)count {
    for (int i = 0; i < count; i++) {
        [_todoCollection addObject:[[NSMutableArray alloc] init]];
    }
}

-(NSMutableArray *)getSection:(NSInteger)section {
    return (0 <= section && section < [self numberOfSections]) ? self.todoCollection[section] : nil;
}

-(void)addTodoObject:(TodoObject *)todo atIndexPath:(NSIndexPath *)indexPath {
    [[self getSection:indexPath.section] insertObject:todo
                                              atIndex:indexPath.row];
}

-(NSMutableArray *)getCompletedTasksSection {
    return [self getSection:[self numberOfSections] - 1];
}


@end
