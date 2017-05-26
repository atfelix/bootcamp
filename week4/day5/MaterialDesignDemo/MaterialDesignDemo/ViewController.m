//
//  ViewController.m
//  MaterialDesignDemo
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "MaterialButtons.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/FLAnimatedImageView.h"
#import "SDWebImage/FLAnimatedImageView+WebCache.h"
#import "SDWebImage/UIView+WebCache.h"

@interface ViewController ()

@property (nonatomic, strong) FLAnimatedImageView *customImageView;

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
    [raisedButton setElevation:1000 forState:UIControlStateNormal];

    [self.view addSubview:raisedButton];

    [SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
    [SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";


}

- (void)tapped:(id)sender {
    NSLog(@"Button was tapped!");
}

@end
