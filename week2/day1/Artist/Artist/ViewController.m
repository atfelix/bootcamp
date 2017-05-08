//
//  ViewController.m
//  Artist
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "ArtistManager.h"
#import "Artist.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) ArtistManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[ArtistManager alloc] init];
}

-(void) updateView {
    Artist *artist = [self.manager randomArtist];
    self.label.text = artist.name;
    [self.label sizeToFit];
    self.imageView.image = artist.photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped {
    [self updateView];
}

@end
