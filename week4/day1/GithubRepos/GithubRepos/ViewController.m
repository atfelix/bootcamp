//
//  ViewController.m
//  GithubRepos
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "Repo.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray<Repo *> *repos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.repos = [[NSMutableArray alloc] init];

    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/lighthouse-labs/repos"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                        if (error) {
                                            NSLog(@"Error: %@", error.localizedDescription);
                                            return;
                                        }

                                        NSError *jsonError = nil;
                                        NSArray *downloadedRepos = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:0
                                                                                                     error:&jsonError];
                                        if (jsonError) {
                                            NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                            return;
                                        }


                                        for (NSDictionary *repo in downloadedRepos) {
                                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                [self.repos addObject:[[Repo alloc] initWithJSONDictionary:repo]];
                                                [self.tableView reloadData];
                                            }];
                                        }


                                    }];
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                          forIndexPath:indexPath];
    Repo *repo = self.repos[indexPath.row];
    cell.nameLabel.text = repo.name;
    cell.repoIdLabel.text = [NSString stringWithFormat:@"%@", @(repo.repoId)];
    cell.repoDescriptionLabel.text = repo.repoDescription;
    cell.urlLabel.text = repo.htmlURLString;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}


@end
