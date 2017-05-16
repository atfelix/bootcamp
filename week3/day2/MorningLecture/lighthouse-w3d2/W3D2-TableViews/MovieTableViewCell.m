//
//  MovieTableViewCell.m
//  W3D2-TableViews
//
//  Created by Kareem Sabri on 2017-05-16.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import "MovieTableViewCell.h"

static NSString *reuseIdentifier = @"MovieTableViewCell";

@implementation MovieTableViewCell

- (void)updateDisplay {
    self.movieImageView.image = self.movie.image;
    self.titleLabel.text = self.movie.title;
    self.genreLabel.text = self.movie.genre;
    self.seenItSwitch.on = self.movie.seenIt;
}

@end
