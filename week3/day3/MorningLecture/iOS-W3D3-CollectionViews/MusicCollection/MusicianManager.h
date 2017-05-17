//
//  MusicianManager.h
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

/*
 * The manager will handle all of the calls from the datasource
 */

@import UIKit;

@class Musician;
@class  PhotoObject;

@interface MusicianManager : NSObject

@property (nonatomic, readonly) NSArray <Musician *>* musicianArray;

-(NSInteger)numberOfSectionsInCollectionView;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(PhotoObject *) dataForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
