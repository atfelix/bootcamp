//
//  PhotoObject.m
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

#import "PhotoObject.h"

@implementation PhotoObject
- (instancetype)initWithName:(NSString *)name
{
  self = [super init];
  if (self) {
    _image = [UIImage imageNamed:name];
  }
  return self;
}
@end
