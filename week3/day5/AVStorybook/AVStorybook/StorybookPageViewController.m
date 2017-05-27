//
//  StorybookPageViewController.m
//  AVStorybook
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "StorybookPageViewController.h"

#import "StoryPart.h"
#import "StoryPartViewController.h"

@interface StorybookPageViewController () <StoryPartDelegate>

@property (nonatomic) NSMutableArray *storyParts;
@property (nonatomic) NSUInteger currentPageIndex;
//@property (nonatomic) UIStoryboard *mainStoryBoard;

@end

@implementation StorybookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    self.dataSource = self;

    for (int i = 0; i < 5; i++) {
        [self.storyParts addObject:[[StoryPart alloc] initWithString:[NSString stringWithFormat:@"message%@.m4a",@(i)]]];
    }



//    self.mainStoryBoard = [UIStoryboard storyboardWithName:@"Main"
//                                                         bundle:nil];

    StoryPartViewController *sbp = [self createViewControllerWithIndex:0];

    [self setViewControllers:@[sbp]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
//    [self.view addSubview:sbp.view];


}

- (StoryPartViewController *)createViewControllerWithIndex:(NSUInteger)index {
    StoryPartViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    vc.index = index;
    vc.delegate = self;
    vc.storyPart = self.storyParts[index];
    return vc;
}


#pragma mark Lazy Instantiation


-(NSMutableArray *)storyParts {
    if (!_storyParts) {
        _storyParts = [[NSMutableArray alloc] init];
    }
    return _storyParts;
}


#pragma mark UIPageViewDataSource methods


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((StoryPartViewController*)viewController).index;
    if (index == 0) {
        return nil;
    }

//    self.currentPageIndex--;
    return [self createViewControllerWithIndex:index-1];
//    return [self viewControllerAtIndex:self.currentPageIndex storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((StoryPartViewController*)viewController).index;
    if (index >= self.storyParts.count-1) {
        return nil;
    }
    return [self createViewControllerWithIndex:index+1];
}

//-(UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
//    if ((self.storyParts.count == 0) || (index >= self.storyParts.count)) {
//        return nil;
//    }
//
//    StoryPartViewController *storyPartVC = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
//    storyPartVC.storyPart = self.storyParts[index];
//    storyPartVC.delegate = self;
//    return storyPartVC;
//}


#pragma mark StoryPartDelegate methods


-(void)deletePage:(UIButton *)sender {
    if (self.storyParts.count > 1) {
        [self.storyParts removeObjectAtIndex:self.currentPageIndex];

        if (self.currentPageIndex == self.storyParts.count) {
            self.currentPageIndex--;
        }
    }
}

-(void)addPage:(UIButton *)sender {
    [self.storyParts addObject:[[StoryPart alloc] initWithString:[NSString stringWithFormat:@"message%@.m4a", @(self.storyParts.count)]]];
}


@end
