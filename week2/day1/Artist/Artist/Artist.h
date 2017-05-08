//
//  Artist.h
//  Artist
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

@import UIKit;

@interface Artist : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) UIImage *photo;

-(instancetype)initWithName:(NSString *)name imageName: (NSString *) imageName;

@end
