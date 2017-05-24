//
//  SearchViewController.h
//  Cats
//
//  Created by atfelix on 2017-05-24.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchProtocol <NSObject>

-(void)saveParameters:(NSString *)searchParameters;

@end

@interface SearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *parameterTextField;
@property (nonatomic, weak) id<SearchProtocol> delegate;

@end
