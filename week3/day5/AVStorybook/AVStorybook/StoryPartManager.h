//
//  StoryPartManager.h
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoryPart;

@interface StoryPartManager : NSObject

@property (nonatomic, copy) NSMutableArray<StoryPart *> *storyPages;

@end
