//
//  MusicianManager.m
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

#import "MusicianManager.h"
#import "Musician.h"

@implementation MusicianManager
- (instancetype)init {
  self = [super init];
  if (self) {
    Musician *m1 = [[Musician alloc] initWithName:@"Taylor Swift"];
    Musician *m2 = [[Musician alloc] initWithName:@"Iggy Pop"];
    Musician *m3 = [[Musician alloc] initWithName:@"Lady Gaga"];
    _musicianArray = @[m1, m2, m3];
  }
  return self;
}

-(NSInteger)numberOfSectionsInCollectionView {
    return self.musicianArray.count;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.musicianArray[section].photoObjectArray.count;
}

-(PhotoObject *)dataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.musicianArray[indexPath.section].photoObjectArray[indexPath.item];
}

@end
