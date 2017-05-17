//
//  PhotoCollectionViewCell.m
//  MusicCollection
//
//  Created by atfelix on 2017-05-17.
//  Copyright © 2017 steve. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

#import "PhotoObject.h"

@interface PhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

-(void)setPhotoObject:(PhotoObject *)photoObject {
    self.imageView.image = photoObject.image;
    _photoObject = photoObject;
}

@end
