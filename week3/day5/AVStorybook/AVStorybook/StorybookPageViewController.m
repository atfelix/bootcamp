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

@interface StorybookPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, StoryPartDelegate>

@property (nonatomic) NSMutableArray *storyParts;
@property (nonatomic) NSUInteger currentPageIndex;

@end

@implementation StorybookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    self.dataSource = self;

    for (int i = 0; i < 5; i++) {
        [self.storyParts addObject:[[StoryPart alloc] initWithString:[NSString stringWithFormat:@"message%@.m4a",@(i)]]];
    }

    self.currentPageIndex = 0;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    StoryPartViewController *initialViewController = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    initialViewController.storyPart = self.storyParts[self.currentPageIndex];
    initialViewController.delegate = self;
    [self setViewControllers:@[initialViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    [self.view addSubview:initialViewController.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark Lazy Instantiation


-(NSMutableArray *)storyParts {
    if (!_storyParts) {
        _storyParts = [[NSMutableArray alloc] init];
    }
    return _storyParts;
}


#pragma mark UIPageViewDataSource methods


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.currentPageIndex <= 0) {
        return nil;
    }

    self.currentPageIndex--;
    return [self viewControllerAtIndex:self.currentPageIndex storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.currentPageIndex >= self.storyParts.count - 1) {
        return nil;
    }

    self.currentPageIndex++;
    return [self viewControllerAtIndex:self.currentPageIndex storyboard:viewController.storyboard];
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    if ((self.storyParts.count == 0) || (index >= self.storyParts.count)) {
        return nil;
    }

    StoryPartViewController *storyPartVC = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    storyPartVC.storyPart = self.storyParts[index];
    storyPartVC.delegate = self;
    return storyPartVC;
}


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
