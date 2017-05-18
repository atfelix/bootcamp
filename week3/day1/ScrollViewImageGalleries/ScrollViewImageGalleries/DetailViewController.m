//
//  DetailViewController.m
//  ScrollViewImageGalleries
//
//  Created by atfelix on 2017-05-18.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGR;

@end

@implementation DetailViewController

-(instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.scrollView addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    self.imageView.userInteractionEnabled = YES;

    self.scrollView.delegate = self;

    self.scrollView.minimumZoomScale = 0.25;
    self.scrollView.maximumZoomScale = 2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
    }

}


#pragma mark UIScrollViewDelegate methods


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
