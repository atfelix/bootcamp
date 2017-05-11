//
//  ViewController.m
//  EnteringAHouse
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *restartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [restartButton setTitle:@"Restart"
                   forState:UIControlStateNormal];
    [restartButton sizeToFit];
    [restartButton addTarget:self
                      action:@selector(restartGame)
            forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                                           target:nil
                                                                                           action:nil];
    self.navigationItem.rightBarButtonItem.customView = restartButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)restartGame {
    NSLog(@"banana");
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
