//
//  MainViewController.m
//  MusicCollection
//
//  Created by steve on 2017-05-16.
//  Copyright © 2017 steve. All rights reserved.
//

#import "MainViewController.h"

#import "MusicianManager.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoObject.h"
#import "DetailViewController.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) MusicianManager *manager;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation MainViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[MusicianManager alloc] init];

    CGFloat width = CGRectGetWidth(self.view.frame) / 2;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).itemSize = CGSizeMake(width, width);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.manager numberOfSectionsInCollectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.manager numberOfItemsInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell"
                                                                              forIndexPath:indexPath];
    cell.photoObject = [self.manager dataForItemAtIndexPath:indexPath];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dvc = [[DetailViewController alloc] init];
    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    dvc.photoObject = [self.manager dataForItemAtIndexPath:indexPath];
}

@end
