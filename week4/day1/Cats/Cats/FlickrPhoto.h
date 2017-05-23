//
//  FlickrPhoto.h
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

@import UIKit;

@protocol FlickrPhotoDelegate <NSObject>

-(void)reloadData;

@end

@interface FlickrPhoto : NSObject

@property (nonatomic) NSString *photoId;
@property (nonatomic) NSString *farm;
@property (nonatomic) NSString *server;
@property (nonatomic) NSString *secret;
@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *image;
@property (nonatomic, weak) id<FlickrPhotoDelegate> delegate;

-(instancetype)initWithInfo:(NSDictionary *)info;
-(NSURL *)url;

@end
