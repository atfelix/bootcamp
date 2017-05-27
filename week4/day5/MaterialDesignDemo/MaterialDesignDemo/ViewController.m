//
//  ViewController.m
//  MaterialDesignDemo
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "MaterialButtons.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MDCRaisedButton *raisedButton = [MDCRaisedButton new];
    [raisedButton setTitle:@"Raised Button" forState:UIControlStateNormal];
    [raisedButton sizeToFit];
    [raisedButton addTarget:self
                     action:@selector(tapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [raisedButton setElevation:10 forState:UIControlStateNormal];

    [self.view addSubview:raisedButton];
}

- (void)tapped:(id)sender {
    NSLog(@"Button was tapped!");
}

@end
