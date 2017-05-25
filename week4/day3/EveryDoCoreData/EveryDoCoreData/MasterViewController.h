//
//  MasterViewController.h
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EveryDoCoreData+CoreDataModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Todo *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

