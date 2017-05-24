//
//  ViewController.m
//  Cats
//
//  Created by atfelix on 2017-05-23.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "DetailViewController.h"
#import "FlickrAPI.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoViewCell.h"
#import "SearchViewController.h"
#import "ShowAllViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, FlickrPhotoDelegate, SearchProtocol>

@property (nonatomic) NSArray<FlickrPhoto *> *photos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSString *currentSearchParameter;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [[NSMutableArray alloc] init];
    self.currentSearchParameter = @"cat";
    self.navigationItem.title = self.currentSearchParameter;
    [self searchFlickr];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Utility methods


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoViewCell"
                                                                          forIndexPath:indexPath];
    FlickrPhoto *photo = self.photos[indexPath.item];
    photo.delegate = self;
    cell.photo = photo;
    cell.photoLabel.text = photo.title;
    cell.photoImageView.image = photo.image;

    return cell;
}

-(void)reloadData {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.collectionView reloadData];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if (![segue.identifier isEqualToString:@"DetailViewSegue"]) {
        return;
    }

    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].lastObject;
    FlickrPhotoViewCell *cell = (FlickrPhotoViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

    if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
        [segue.destinationViewController setPhoto:cell.photo];
    }
}

- (IBAction)searchButtonTapped:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    SearchViewController *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    searchVC.delegate = self;
    [self presentViewController:searchVC
                       animated:YES
                     completion:nil];
}

-(void)saveParameters:(NSString *)searchParameters {
    self.currentSearchParameter = searchParameters;
    self.navigationItem.title = searchParameters;
    [self searchFlickr];
}

-(void)searchFlickr {
    [FlickrAPI searchFor:self.currentSearchParameter
       completionHandler:^(NSArray *searchResults) {
           self.photos = searchResults;
           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               [self.collectionView reloadData];
           }];
       }];
}

- (IBAction)showAllButtonTapped:(UIBarButtonItem *)sender {

    ShowAllViewController *showAllVC = [[ShowAllViewController alloc] init];
    showAllVC.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];

    for (FlickrPhoto *photo in self.photos) {

        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        pin.title = photo.title;
        [FlickrAPI getGeoLocationForPhoto:photo
                        completionHandler:^(CLLocation *location) {
                            photo.location = location;
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                pin.coordinate = location.coordinate;
                            }];
                        }];
        [showAllVC.mapView addAnnotation:pin];
    }

    [self.navigationController pushViewController:showAllVC
                                         animated:YES];
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if (sender.on) {
        [self.locationManager requestLocation];
        [FlickrAPI getPhotosForGeoLocation:self.locationManager.location
                         completionHandler:^(NSArray *searchResults) {
                             self.photos = searchResults;
                             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                 [self.collectionView reloadData];
                                 self.navigationItem.title = @"Photos near you";
                             }];
                         }];
    }
    else {
        [self searchFlickr];
        self.navigationItem.title = self.currentSearchParameter;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}


@end
