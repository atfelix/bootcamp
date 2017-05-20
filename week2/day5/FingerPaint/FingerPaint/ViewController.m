//
//  ViewController.m
//  FingerPaint
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "DrawView.h"

@interface ViewController () <DrawViewDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Draw View Delegate methods


-(UIColor *)currentStrokeColor {
    return [UIColor purpleColor];
}

@end
