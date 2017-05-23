//
//  ViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "FlickrAPI.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSArray *photos;
@property (nonatomic) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.photos = [[NSMutableArray alloc] init];
    self.images = [[NSMutableArray alloc] init];
    [FlickrAPI searchFor:@"cat"
       completionHandler:^(NSArray *searchResults) {
           self.photos = searchResults;
           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               [self.collectionView reloadData];
           }];
       }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Utility methods


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoViewCell"
                                                                          forIndexPath:indexPath];
    FlickrPhoto *photo = self.photos[indexPath.item];
    cell.photo = photo;
    cell.photoLabel.text = photo.title;
    cell.photoImageView.image = photo.image;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.collectionView reloadData];
    }];

    return cell;
}

@end
