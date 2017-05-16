//
//  MovieTableViewCell.h
//  W3D2-TableViews
//
//  Created by Kareem Sabri on 2017-05-16.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *seenItSwitch;

-(void)updateDisplay;

@end
