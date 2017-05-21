//
//  PhotoManager.h
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class PhotoObject;

@interface PhotoManager : NSObject

@property (nonatomic) NSMutableArray<PhotoObject *> *photoCollection;

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end
