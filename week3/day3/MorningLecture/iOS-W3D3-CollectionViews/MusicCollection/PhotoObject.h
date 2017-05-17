//
//  PhotoObject.h
//  MusicCollection
//
//  Created by steve on 2016-11-15.
//  Copyright © 2016 steve. All rights reserved.
//

/*
 * Responsible for handling the image. 
 * If there was other data it would be here, like say, the location of the picture, date, etc. 
 * Any photo meta data could be handled here. 
 * We're just keeping it simple.
 */

@import UIKit;

@interface PhotoObject : NSObject
- (instancetype)initWithName:(NSString *)name;
@property (nonatomic, readonly)UIImage *image;
@end
