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
#import "HeaderView.h"

#define LocationSegmentedControlIndex 0
#define SubjectSegmentedControlIndex 1

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
        [self sortByProperty:NO withSelector:@selector(compareBasedOnLocation:)];
        _sortedByLocation = YES;
        [self populateSections];
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
    return collection;
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
    if (self.isSortedByLocation) {
        [self sortByLocation];
    }
    else {
        [self sortBySubject];
    }

    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
                                                                forIndexPath:indexPath];
    cell.imageFilename = self.photoCollection[[self getIndexForIndexPath:indexPath]].photoFilename;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < 0 || self.sectionCounts.count <= section) {
        return 0;
    }
    return [self.sectionCounts[section] integerValue];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderView *headerView;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                        withReuseIdentifier:@"HeaderView"
                                                               forIndexPath:indexPath];
        headerView.sectionTitleLabel.text = self.sectionHeadings[indexPath.section];
    }

    return headerView;
}


#pragma mark Utility methods


-(NSInteger)getIndexForIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = 0;

    for (int i = 0; i < indexPath.section; i++) {
        index += [self.sectionCounts[i] integerValue];
    }

    index += indexPath.item;

    return index;
}

-(void)populateSections {
    if (self.isSortedByLocation) {
        [self populationSectionsForLocation];
    }
    else {
        [self populationSectionsForSubject];
    }
}

-(void)populationSectionsForLocation {
    [self populationSectionsBasedOnProperty:self.isSortedByLocation withSortSelector:@selector(compareBasedOnLocation:) withSelector:@selector(photoTakenLocation)];
}

-(void)populationSectionsForSubject {
    [self populationSectionsBasedOnProperty:!self.isSortedByLocation withSortSelector:@selector(compareBasedOnSubject:) withSelector:@selector(photoSubject)];
}

-(void)populationSectionsBasedOnProperty:(BOOL)isAlreadySorted withSortSelector:(SEL)sortSelector withSelector:(SEL)selector {
    _sectionHeadings = [[NSMutableArray alloc] init];
    _sectionCounts = [[NSMutableArray alloc] init];

    [self sortByProperty:isAlreadySorted withSelector:sortSelector];

    for (int i = 0; i < self.photoCollection.count; i++) {
        PhotoObject *photo = self.photoCollection[i];
        if (i == 0 || ![[photo performSelector:selector] isEqualToString:_sectionHeadings.lastObject]) {
            [_sectionHeadings addObject:[photo performSelector:selector]];
            [_sectionCounts addObject:@(0)];
        }
        _sectionCounts[_sectionCounts.count - 1] = @([_sectionCounts.lastObject integerValue] + 1);
    }
}


#pragma mark Sorting methods

-(void)sortByProperty:(BOOL)isAlreadySortedOnProperty withSelector:(SEL)selector {
    if (isAlreadySortedOnProperty) {
        return;
    }

    if (![PhotoObject instancesRespondToSelector:selector]) {
        NSLog(@"Can't sort PhotoObjects");
        return;
    }

    [_photoCollection sortUsingComparator:^NSComparisonResult(PhotoObject *a, PhotoObject *b) {
        return (NSComparisonResult)[a performSelector:selector withObject:b];
    }];
}

-(void)sortByLocation {
    [self sortByProperty:self.isSortedByLocation withSelector:@selector(compareBasedOnLocation:)];
}

-(void)sortBySubject {
    [self sortByProperty:!self.isSortedByLocation withSelector:@selector(compareBasedOnSubject:)];
}


#pragma mark Segmented Control method

-(void)toggleSectionType:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == LocationSegmentedControlIndex) {
        [self populationSectionsForLocation];
    }
    else if (sender.selectedSegmentIndex == SubjectSegmentedControlIndex) {
        [self populationSectionsForSubject];
    }
    self.sortedByLocation ^= YES;
}

@end
