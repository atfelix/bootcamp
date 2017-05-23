//
//  Repo.m
//  GithubRepos
//
//  Created by atfelix on 2017-05-22.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "Repo.h"

@implementation Repo

-(instancetype)initWithJSONDictionary:(NSDictionary *)info {

    self = [super init];
    if (self) {
        _name = info[@"name"];
        _repoId = (NSUInteger)info[@"id"];
        _htmlURLString = info[@"html_url"];
        _repoDescription = (![info[@"description"] isKindOfClass:[NSNull class]]) ? info[@"description"] : @"No description";
    }
    return self;
}

@end
