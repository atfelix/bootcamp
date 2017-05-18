//
//  ViewController.m
//  ScrollViewImageGalleries
//
//  Created by atfelix on 2017-05-17.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "DetailViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) UIPageControl *control;
@property (nonatomic) NSMutableArray<UIImageView *> *imageViewArray;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageViewArray = [[NSMutableArray alloc] init];

    [self createImageViews];

    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;

    self.pageControl.userInteractionEnabled = YES;

    [self.pageControl addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(pageTapped:)]];

    [self addConstraintToImageViews];

    [self.view bringSubviewToFront:self.pageControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createImageViews {

    for (NSString *name in @[@"Lighthouse-in-Field.jpg", @"Lighthouse-night.jpg", @"Lighthouse.jpg"]) {

        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];

        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;

        [self.imageViewArray addObject:imageView];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleTap:)]];
    }

    for (UIImageView* imageView in self.imageViewArray) {
        [self.scrollView addSubview:imageView];
    }

}

-(void)addConstraintToImageViews {

    [self translatesAutoresizingMasksToConstraints];

    CGFloat width = self.view.bounds.size.width;

    self.scrollView.contentSize = CGSizeMake(width * self.imageViewArray.count,
                                             self.view.frame.size.height);

    for (int i = 0; i < self.imageViewArray.count; i++) {
        UIImageView *imageView = self.imageViewArray[i];

        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [imageView.widthAnchor constraintEqualToConstant:width].active = YES;

        if (i == 0) {
            [imageView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor].active = YES;
        }
        else {
            [imageView.leadingAnchor constraintEqualToAnchor:self.imageViewArray[i - 1].trailingAnchor].active = YES;
        }
    }
    [self.imageViewArray[self.imageViewArray.count - 1].trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor ].active = YES;

}

-(void)translatesAutoresizingMasksToConstraints {
    for (UIImageView *iv in self.imageViewArray) {
        iv.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

-(void)handleTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"DetailSegue"
                              sender:sender];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITapGestureRecognizer *)sender {
    int index = (int) ([sender locationInView:self.scrollView].x / self.view.bounds.size.width);

    if ([segue.destinationViewController respondsToSelector:@selector(setImage:)]) {
        [segue.destinationViewController setImage:self.imageViewArray[index].image];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int) (self.scrollView.bounds.origin.x / self.view.bounds.size.width);
}

-(void)pageTapped:(UITapGestureRecognizer *)sender {
    CGFloat locationX = [sender locationInView:sender.view].x;
    CGFloat partitionSize = (int) sender.view.bounds.size.width / self.pageControl.numberOfPages;

    self.pageControl.currentPage = (int) (locationX / partitionSize);

    [UIView animateWithDuration:1
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.scrollView.bounds = CGRectMake(self.scrollView.frame.size.width * self.pageControl.currentPage,
                                                             self.scrollView.frame.origin.y,
                                                             self.scrollView.frame.size.width,
                                                             self.scrollView.frame.size.height);
                     }
                     completion:nil];
}

@end
