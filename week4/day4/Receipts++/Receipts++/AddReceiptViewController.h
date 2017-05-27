//
//  AddReceiptViewController.h
//  Receipts++
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreData;

#import "Receipt+CoreDataClass.h"
#import "Receipt+CoreDataProperties.h"
#import "Tag+CoreDataClass.h"
#import "Tag+CoreDataProperties.h"

@protocol AddReceiptViewControllerDelegate

-(void)addReceiptViewControllerDidSave;
-(void)addReceiptViewControllerDidCancel:(Receipt *)receiptToDelete;
-(NSManagedObjectContext *)managedObjectContext;

@end

@interface AddReceiptViewController : UIViewController

@property (nonatomic, strong) Receipt *receipt;
@property (nonatomic, weak) id<AddReceiptViewControllerDelegate> delegate;

@end
