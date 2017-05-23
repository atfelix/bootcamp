//
//  ViewController.h
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoryPart.h"

@protocol StoryPartDelegate <NSObject>

-(void)deletePage:(UIButton *)sender;
-(void)addPage:(UIButton *)sender;

@end

@interface StoryPartViewController : UIViewController

@property (nonatomic, strong) StoryPart *storyPart;
@property (nonatomic, weak) id<StoryPartDelegate> delegate;

@end
