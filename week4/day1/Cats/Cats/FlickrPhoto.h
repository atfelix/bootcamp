//
//  FlickrPhoto.h
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

-(instancetype)initWithInfo:(NSDictionary *)info;
-(NSURL *)url;

@end
