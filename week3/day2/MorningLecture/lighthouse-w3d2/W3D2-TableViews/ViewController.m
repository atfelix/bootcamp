//
//  ViewController.m
//  W3D2-TableViews
//
//  Created by Kareem Sabri on 2017-05-16.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "Movie.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Movie*> *movies;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.movies = [self getMovies];
    [self.tableView reloadData];
}

// - MARK: UITableViewDataSource Conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell" forIndexPath:indexPath];
    cell.movie = self.movies[indexPath.row];
    [cell updateDisplay];
    return cell;
}

- (NSMutableArray*)getMovies {
    Movie *movie1 = [[Movie alloc]initWithTitle:@"Fargo" andGenre:@"Noir" andImage:[UIImage imageNamed:@"fargo"]];
    Movie *movie2 = [[Movie alloc]initWithTitle:@"Fast & Furios" andGenre:@"Action" andImage:[UIImage imageNamed:@"fastfurious"]];
    Movie *movie3 = [[Movie alloc]initWithTitle:@"Rush Hour" andGenre:@"Comedy" andImage:[UIImage imageNamed:@"rushhour"]];
    return [[NSMutableArray<Movie*> alloc]initWithObjects:movie1, movie2, movie3, nil];
}


@end
