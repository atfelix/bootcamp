//
//  TodoManager.m
//  EveryDo
//
//  Created by atfelix on 2017-05-19.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TodoManager.h"

@implementation TodoManager

-(instancetype)initWithSectionCapacity:(NSInteger)count {

    self = [super init];
    if (self) {
        _todoCollection = [[NSMutableArray alloc] init];
        [self initSections:count];
    }
    return self;
}

-(void) initSections:(NSInteger)count {
    for (int i = 0; i < count; i++) {
        [_todoCollection addObject:[[NSMutableArray alloc] init]];
    }
}

@end
