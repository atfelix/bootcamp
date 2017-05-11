//
//  LHWCityViewController.m
//  Weather
//
//  Created by atfelix on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LHWCityViewController.h"

#import "LHWCity.h"
#import "LHWDetailViewController.h"

@interface LHWCityViewController ()

@end

@implementation LHWCityViewController

-(instancetype)initWithCity:(LHWCity *)city {

    self = [super init];
    if (self) {
        _city = city;
    }
    return self;
}

- (instancetype)init {
    return [self initWithCity:[[LHWCity alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:[NSString stringWithFormat:@"Show %@ Details", self.city.cityName]
            forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [button addTarget:self
               action:@selector(showWeatherDetails:)
     forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addButton.frame = CGRectMake(0, 0, 40, 40);
    [addButton setTitle:@"Add"
               forState:UIControlStateNormal];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:nil];
    barButtonItem.customView = addButton;
    self.navigationItem.rightBarButtonItem = barButtonItem;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showWeatherDetails:(UIButton *)sender {

    LHWDetailViewController *detailViewController = [[LHWDetailViewController alloc] init];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", self.city.imageName]]];

    imageView.frame = self.view.frame;

    [detailViewController.view addSubview:imageView];

    UIImageView *weatherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", self.city.weatherName]]];

    weatherImageView.center = self.view.center;

    [imageView addSubview:weatherImageView];

    [self.navigationController pushViewController:detailViewController
                                         animated:NO];
}

@end
