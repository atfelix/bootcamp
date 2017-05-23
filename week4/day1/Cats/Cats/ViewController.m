//
//  ViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "FlickrAPI.h"

@interface ViewController ()

@property (nonatomic) NSArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.photos = [[NSMutableArray alloc] init];
    [FlickrAPI searchFor:@"cat"
       completionHandler:^(NSArray *searchResults) {
           NSLog(@"Found: %@", searchResults);
           self.photos = searchResults;
       }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Utility methods


-(void)getPhotosBasedOn:(NSString *)searchQuery {

}


@end
