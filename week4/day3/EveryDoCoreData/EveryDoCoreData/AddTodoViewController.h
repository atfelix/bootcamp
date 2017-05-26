//
//  AddTodoViewController.h
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Todo+CoreDataClass.h"
#import "Todo+CoreDataProperties.h"

@protocol AddTodoViewControllerProtocol

-(void)addTodoViewControllerDidSave;
-(void)addTodoViewControllerDidCancel:(Todo *)courseToDelete;

@end

@interface AddTodoViewController : UIViewController

@property (nonatomic, strong) Todo *todo;
@property (nonatomic, weak) id<AddTodoViewControllerProtocol> delegate;

@end
