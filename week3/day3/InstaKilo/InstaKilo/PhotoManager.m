//
//  PhotoManager.m
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PhotoManager.h"

#import "PhotoCell.h"
#import "PhotoObject.h"

@interface PhotoManager ()

@property (nonatomic, assign, getter=isSortedByLocation) BOOL sortedByLocation;
@property (nonatomic) NSMutableArray<NSString *> *sectionHeadings;
@property (nonatomic) NSMutableArray<NSNumber *> *sectionCounts;

@end

@implementation PhotoManager

-(instancetype)init {

    self = [super init];
    if (self) {
        _photoCollection = [self initialPhotoCollection];
        _sortedByLocation = YES;
    }
    return self;
}

-(NSMutableArray<PhotoObject *> *)initialPhotoCollection {
    NSMutableArray *collection = [[NSMutableArray alloc] init];

    NSString *fileExtension = @".JPG";
    NSString *elkFalls = @"elk falls-";
    NSString *banff = @"DSC0";
    NSString *cathedralGrove = @"cathedral grove-";

    for (int i = 0; i < 5; i++) {
        [collection addObject:[[PhotoObject alloc] initWithLocation:@"Elk Falls"
                                                         andSubject:(arc4random_uniform(2)) ? @"Nature" : @"Wilderness"
                                                        andFilename:[NSString stringWithFormat:@"%@%@%@", elkFalls, @(i + 2), fileExtension]]];
        [collection addObject:[[PhotoObject alloc] initWithLocation:@"Banff"
                                                         andSubject:(arc4random_uniform(2)) ? @"Mountains" : @"Wilderness"
                                                        andFilename:[NSString stringWithFormat:@"%@%@%@", banff, @(i + 3588), fileExtension]]];
        [collection addObject:[[PhotoObject alloc] initWithLocation:@"Cathedral Grove"
                                                         andSubject:(arc4random_uniform(2)) ? @"Nature" : @"Wilderness"
                                                        andFilename:[NSString stringWithFormat:@"%@%@%@", cathedralGrove, @(i), fileExtension]]];
    }
    return [collection copy];
}


#pragma mark Lazy Initialization


-(NSMutableArray<NSString *> *)sectionHeadings {
    if (!_sectionHeadings) {
        _sectionHeadings = [[NSMutableArray<NSString *> alloc] init];
    }
    return _sectionHeadings;
}

-(NSMutableArray<NSNumber *> *)sectionCounts {
    if (!_sectionHeadings) {
        _sectionCounts = [[NSMutableArray<NSNumber *> alloc] init];
    }
    return _sectionCounts;
}


#pragma mark Collection View Data Source methods


-(NSInteger)numberOfSectionsInCollectionView:(id)collectionView {
    return self.sectionHeadings.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
                                                                forIndexPath:indexPath];
    cell.imageFilename = self.photoCollection[0].photoFilename;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < 0 || self.sectionCounts.count <= section) {
        return 0;
    }
    return [self.sectionCounts[section] integerValue];
}


#pragma mark Utility methods


-(void)sortByProperty:(BOOL)isAlreadySortedOnProperty withSelector:(SEL)selector {
    if (isAlreadySortedOnProperty) {
        return;
    }

    if (![PhotoObject instancesRespondToSelector:selector]) {
        NSLog(@"Can't sort PhotoObjects");
        return;
    }

    [self.photoCollection sortUsingComparator:^NSComparisonResult(PhotoObject *a, PhotoObject *b) {
        return (NSComparisonResult)[a performSelector:selector withObject:b];
    }];
}

-(void)sortByLocation {
    [self sortByProperty:self.isSortedByLocation withSelector:@selector(compareBasedOnLocation:)];
}

-(void)sortBySubject {
    [self sortByProperty:!self.isSortedByLocation withSelector:@selector(compareBasedOnSubject:)];
}

@end
