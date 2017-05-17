//
//  Musician.m
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

#import "Musician.h"
#import "PhotoObject.h"

@implementation Musician
- (instancetype)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    _name = name;
    [self createPhotos];
  }
  return self;
}

- (void)createPhotos {
  if ([_name isEqualToString:@"Taylor Swift"]) {
    [self createPhotosWithName:@"swift"];
  }
  if ([_name isEqualToString:@"Iggy Pop"]) {
    [self createPhotosWithName:@"iggy"];
  }
  if ([_name isEqualToString:@"Lady Gaga"]) {
    [self createPhotosWithName:@"lady"];
  }
}

- (void)createPhotosWithName:(NSString *)name {
  NSMutableArray <PhotoObject *> *temp = [NSMutableArray array];
  for (NSInteger i = 1; i < 7; ++i) {
    NSString *imgName = [NSString stringWithFormat:@"%@%ld%ld.jpg", name, (long)0, (long)i];
    [temp addObject:[[PhotoObject alloc] initWithName:imgName]];
  }
  _photoObjectArray = [temp copy];
}


@end
