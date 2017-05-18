//
//  DetailViewController.m
//  ScrollViewImageGalleries
//
//  Created by atfelix on 2017-05-18.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGR;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lighthouse.jpg"]];
    [self.scrollView addSubview:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    [imageView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = YES;
    [imageView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    imageView.userInteractionEnabled = YES;

    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2.0;
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

@end
