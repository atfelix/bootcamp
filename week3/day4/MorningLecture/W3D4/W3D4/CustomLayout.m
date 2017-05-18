//
//  CustomLayout.m
//  W3D4
//
//  Created by atfelix on 2017-05-18.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout ()

@property (nonatomic) NSArray *attributes;

@end

@implementation CustomLayout

-(void)prepareLayout {
    NSMutableArray *results = [[NSMutableArray alloc] init];

    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i
                                                     inSection:0];
        UICollectionViewLayoutAttributes *attributes;
        attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(arc4random_uniform(self.collectionView.bounds.size.width),
                                      arc4random_uniform(self.collectionView.bounds.size.height),
                                      20,
                                      20);
        [results addObject:attributes];
    }
    self.attributes = results;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *results = [[NSMutableArray alloc] init];

    for (UICollectionViewLayoutAttributes *attributes in self.attributes) {
        if (CGRectIntersectsRect(attributes.frame, self.collectionView.frame)) {
            [results addObject:attributes];
        }
    }

    return results;
}

-(CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.attributes[indexPath.item];
}

@end
