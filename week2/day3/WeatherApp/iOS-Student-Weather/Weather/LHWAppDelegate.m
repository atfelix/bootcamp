//
//  LHWAppDelegate.m
//  Weather
//
//  Created by Steven Masuch on 2014-07-30.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LHWAppDelegate.h"

#import "LHWCity.h"
#import "LHWCityViewController.h"

@implementation LHWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // Your code goes here
    // Don't forget to assign the window a rootViewController

    NSArray<NSString *> *cityNames = @[
                                                @"Vancouver",
                                                @"Toronto",
                                                @"Montréal",
                                                @"New York",
                                                @"Paris"
    ];

    NSArray<NSString *> *cityImageNames = @[
                                                @"vancouver",
                                                @"toronto",
                                                @"montréal",
                                                @"new-york",
                                                @"paris"
    ];

    NSArray<UIColor *> *colors = @[
                                                [UIColor redColor],
                                                [UIColor blueColor],
                                                [UIColor greenColor],
                                                [UIColor purpleColor],
                                                [UIColor yellowColor]
    ];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSMutableArray<UINavigationController *> *navControllers = [[NSMutableArray alloc] init];

    for (int i = 0; i < 5; i++) {
        LHWCity *city = [[LHWCity alloc] initWithCityName:cityNames[i]
                                             andImageName:cityImageNames[i]];
        UINavigationController *nav = [[UINavigationController alloc] init];
        nav.title = city.cityName;
        nav.tabBarItem.image = [UIImage imageNamed:city.weatherName];

        LHWCityViewController *cityViewController = [[LHWCityViewController alloc] initWithCity:city];
        cityViewController.view.tintColor = colors[i];
        nav.viewControllers = @[cityViewController];

        [navControllers addObject:nav];
    }

    tabBarController.viewControllers = navControllers;

    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
