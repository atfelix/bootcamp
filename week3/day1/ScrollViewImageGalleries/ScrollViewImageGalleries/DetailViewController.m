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
@property (nonatomic) CGFloat aspectRatio;
@property (nonatomic) NSMutableArray<NSLayoutAnchor *> *anchorArray;

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

    self.anchorArray = [[NSMutableArray alloc] init];

    self.imageView = [[UIImageView alloc] initWithImage:self.image];

    [self.scrollView addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollView.delegate = self;

    self.aspectRatio = [self getAspectRatio];
    [self setImageViewFrameWithWidth:self.view.frame.size.width
                           andHeight:self.view.frame.size.height];

    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIScrollViewDelegate methods


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


#pragma mark Aspect Ratio

-(CGFloat)getAspectRatio {
    return self.image.size.width / self.image.size.height;
}

-(void)setImageViewFrameWithWidth:(CGFloat)largeWidth andHeight:(CGFloat)largeHeight {
    CGFloat width, height;

    if (self.aspectRatio < 1) {
        height = largeHeight;
        width = height * self.aspectRatio;
    }
    else {
        width = largeWidth;
        height = width / self.aspectRatio;
    }

    [self.imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = YES;
    [self.imageView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.scrollView.heightAnchor].active = YES;
}

@end
