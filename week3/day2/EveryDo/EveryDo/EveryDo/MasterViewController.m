//
//  MasterViewController.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "MasterViewController.h"

#import "AddTodoItemViewController.h"
#import "DetailViewController.h"
#import "TodoTableViewCell.h"
#import "TodoObject.h"

@interface MasterViewController () <AddTodoItemDelegate>

@property (nonatomic) NSMutableArray<TodoObject *> *todoObjects;

@end

@implementation MasterViewController

-(NSMutableArray *)todoObjects {
    if (!_todoObjects) {
        _todoObjects = [[NSMutableArray<TodoObject *> alloc] init];
    }
    return _todoObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertNewObject:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    
    AddTodoItemViewController *addTodoItemViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddTodoItemViewController"];
    addTodoItemViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    addTodoItemViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    [self presentViewController:addTodoItemViewController
                       animated:YES
                     completion:^{
                         addTodoItemViewController.delegate = self;
                     }];
    return;

    if (!self.todoObjects) {
        self.todoObjects = [[NSMutableArray alloc] init];
    }
    TodoObject *todoObject = [[TodoObject alloc] init];
    [self.todoObjects insertObject:todoObject atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TodoObject *object = self.todoObjects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoTableViewCell" forIndexPath:indexPath];
    cell.todoObject = self.todoObjects[indexPath.row];
    [cell updateDisplay];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)saveTodoItem:(TodoObject *)todo {
    [self.todoObjects addObject:todo];
    [self.tableView reloadData];
}

@end
