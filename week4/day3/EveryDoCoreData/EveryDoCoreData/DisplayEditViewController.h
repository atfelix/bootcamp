//
//  DisplayEditViewController.h
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Todo+CoreDataClass.h"
#import "Todo+CoreDataProperties.h"

@interface DisplayEditViewController : UIViewController

@property (nonatomic) Todo* todo;

@end
