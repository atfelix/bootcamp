//
//  DetailViewController.h
//  ScrollViewImageGalleries
//
//  Created by atfelix on 2017-05-18.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic) UIImage *image;

-(instancetype)initWithImage:(UIImage *)image;

@end
