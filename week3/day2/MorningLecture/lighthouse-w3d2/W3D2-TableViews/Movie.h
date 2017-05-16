//
//  Movie.h
//  W3D2-TableViews
//
//  Created by Kareem Sabri on 2017-05-16.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) UIImage *image;
@property (assign) BOOL seenIt;

- (instancetype)initWithTitle:(NSString*)title andGenre:(NSString*)genre andImage: (UIImage*)image;

@end
