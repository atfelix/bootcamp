//
//  Repo.h
//  GithubRepos
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger repoId;
@property (nonatomic, copy) NSString *htmlURLString;
@property (nonatomic, copy) NSString *repoDescription;

-(instancetype)initWithJSONDictionary:(NSDictionary *)info;

@end
