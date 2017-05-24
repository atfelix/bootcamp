//
//  DetailViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DetailViewController.h"

@import SafariServices;

#import "FlickrPhoto.h"
#import "FlickrAPI.h"
#import "MapViewController.h"

@interface DetailViewController ()

@property (nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSURL *photoURL;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoImageView.image = self.photo.image;
    self.titleLabel.text = self.photo.title;
    self.photoImageView.backgroundColor = [UIColor purpleColor];
    [FlickrAPI getInfoForPhoto:self.photo
             completionHandler:^(NSArray *tagsFound, NSURL *url) {
                 self.tags = tagsFound;
                 self.photoURL = url;
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     [self addTextViewText];
                 }];
             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addTextViewText {
    NSMutableString *string = [self.tags[0] mutableCopy];

    for (NSString *x in [self.tags subarrayWithRange:NSMakeRange(1, self.tags.count - 2)]) {
        [string appendFormat:@", %@", x];
    }

    self.textView.text = [string copy];
}

-(IBAction)buttonTapped:(UIButton *)sender {
    [self.navigationController pushViewController:[[SFSafariViewController alloc] initWithURL:self.photoURL]
                                         animated:YES];
}

-(IBAction)mapButtonTapped:(UIButton *)sender {
    [FlickrAPI getGeoLocationForPhoto:self.photo completionHandler:^(CLLocation *location) {
        self.photo.location = location;
        NSLog(@"%@", self.photo.location);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
            MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
            pin.title = self.photo.title;
            pin.coordinate = self.photo.location.coordinate;

            [mapView addAnnotation:pin];
            [mapView setRegion:MKCoordinateRegionMake(location.coordinate,
                                                      MKCoordinateSpanMake(0.5f, 0.5f))
                      animated:YES];

            MapViewController *mapVC = [[MapViewController alloc] init];
            mapVC.mapView = mapView;

            [self.navigationController pushViewController:mapVC
                                                 animated:YES];
        }];
    }];
}

@end
