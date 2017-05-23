//
//  FlickrPhotoViewCell.h
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;

@interface FlickrPhotoViewCell : UICollectionViewCell

@property (nonatomic) FlickrPhoto *photo;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end
