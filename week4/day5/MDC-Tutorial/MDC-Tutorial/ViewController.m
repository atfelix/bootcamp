//
//  ViewController.m
//  MDC-Tutorial
//
//  Created by atfelix on 2017-05-27.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.appBar = [[MDCAppBar alloc] init];
    [self addChildViewController:self.appBar.headerViewController];
    self.appBar.headerViewController.headerView.backgroundColor = [UIColor colorWithRed:1.0 green:0.76 blue:0.03 alpha:1.0];
    self.appBar.headerViewController.headerView.trackingScrollView = self.collectionView;
    self.appBar.navigationBar.tintColor = [UIColor blackColor];
    [self.appBar addSubviewsToParent];

    self.title = @"Material Components";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(barButtonDidTap:)];

    self.fab = [[MDCFloatingButton alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.fab];

    self.fab.translatesAutoresizingMaskIntoConstraints = NO;
    [self.fab.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0].active = YES;
    [self.fab.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -16.0].active = YES;
    [self.fab.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -16.0].active = YES;

    [self.fab setTitle:@"+" forState:UIControlStateNormal];
    [self.fab setTitle:@"-" forState:UIControlStateSelected];
    [self.fab addTarget:self action:@selector(fabDidTap:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    MDCCollectionViewTextCell *textCell = (MDCCollectionViewTextCell *)cell;
    NSArray<NSString *> *animals = @[@"Lions", @"Tigers", @"Bears", @"Monkeys"];
    textCell.textLabel.text = animals[indexPath.row];
    return textCell;
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
        [self.appBar.headerViewController.headerView trackingScrollViewDidScroll];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
        [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
        [self.appBar.headerViewController.headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
        [self.appBar.headerViewController.headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                                                               targetContentOffset:targetContentOffset];
    }
}


- (void)barButtonDidTap:(id)sender {
    self.editor.editing = !self.editor.editing;
    NSString *buttonTitle = self.editor.editing ? @"Cancel" : @"Edit";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(barButtonDidTap:)];
}

- (void)fabDidTap:(id)sender {
    MDCFloatingButton *button = (MDCFloatingButton *)sender;
    button.selected = !button.isSelected;
}

@end
