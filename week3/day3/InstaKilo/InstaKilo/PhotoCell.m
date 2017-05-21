//
//  PhotoCell.m
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

-(void)setImageFilename:(NSString *)imageFilename {
    self.imageView.image = [UIImage imageNamed:imageFilename];
    _imageFilename = imageFilename;
}

@end
