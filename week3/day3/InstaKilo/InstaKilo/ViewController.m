//
//  ViewController.m
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "PhotoManager.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Lazy Initialization of manager


-(PhotoManager *)manager {
    if (!_manager) {
        _manager = [[PhotoManager alloc] init];
    }
    return _manager;
}


#pragma mark Collection View Data Source methods


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.manager collectionView:collectionView numberOfItemsInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.manager collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.manager numberOfSectionsInCollectionView:collectionView];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return [self.manager collectionView:collectionView
      viewForSupplementaryElementOfKind:kind
                            atIndexPath:indexPath];
}

- (IBAction)controlChanged:(UISegmentedControl *)sender {
    [self.manager toggleSectionType:sender];
    [self.collectionView reloadData];
}

@end
