//
//  ViewController.m
//  iPhoneImage
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPhotoFromURLString:@"http://i.imgur.com/bktnImE.png"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPhotoFromURLString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Error: %@", error.localizedDescription);
                                                        return;
                                                    }
                                                    NSData *data = [NSData dataWithContentsOfURL:location];
                                                    UIImage *image = [UIImage imageWithData:data];
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                        self.imageView.image = image;
                                                    }];
                                                }];
    [task resume];
}

- (IBAction)getRandomPhone:(UIButton *)sender {
    NSString *string = @[
                            @"http://imgur.com/bktnImE.png",
                            @"http://imgur.com/zdwdenZ.png",
                            @"http://imgur.com/CoQ8aNl.png",
                            @"http://imgur.com/2vQtZBb.png",
                            @"http://imgur.com/y9MIaCS.png"
                            ][arc4random_uniform(5)];
    [self getPhotoFromURLString:string];
}

@end
