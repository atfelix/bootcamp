//
//  Musician.h
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

/*
 * Each Musician manages a number of PhotoObject instances stored in an array.
 * The Musician object models the collectionview's sections.
 * The section headers will be populated using the "name" property.
 */

@import UIKit;
@class PhotoObject;

@interface Musician : NSObject
@property (nonatomic, readonly) NSArray <PhotoObject *>*photoObjectArray;
@property (nonatomic, readonly) NSString *name;
- (instancetype)initWithName:(NSString *)name;
@end
