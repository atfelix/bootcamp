//
//  StoryPartManager.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StoryPartManager.h"

#import "StoryPart.h"

#define kNumberOfInitialPages 5

@implementation StoryPartManager

- (instancetype)init {

    self = [super init];
    if (self) {
        [self initializePages];
    }
    return self;
}

-(void)initializePages {
    NSString *fileRootname = @"recording";
    NSString *fileExtenstion = @".m4a";

    _storyPages = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfInitialPages; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@", fileRootname, @(i), fileExtenstion];
        [_storyPages addObject:[[StoryPart alloc] initWithString:[NSString stringWithFormat:@"%@",fileName]]];
    }
}

@end
