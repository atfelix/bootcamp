//
//  ViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "FLICKR_API_KEYS.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray *catPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotosBasedOnSearchParameter:@"cats"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Utility Methods


-(void)getPhotosBasedOnSearchParameter:(NSString *)searchQuery {
    NSString *baseURLString = @"https://api.flickr.com/services/rest/";
    NSString *flickrMethodName = @"flickr.photos.search"
    

}

@end
