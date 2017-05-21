//
//  PhotoObject.m
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "PhotoObject.h"

@implementation PhotoObject

-(instancetype)initWithLocation:(NSString *)location andSubject:(NSString *)subject andFilename:(NSString *)filename {

    self = [super init];
    if (self) {
        _photoTakenLocation = location;
        _photoSubject = subject;
        _photoFilename = filename;
    }
    return self;
}

-(instancetype)init {
    return [self initWithLocation:@"NO PLACE" andSubject:@"NO SUBJECT" andFilename:@"NO FILENAME"];
}


#pragma mark Comparison functions


-(NSComparisonResult)compareBasedOnSubject:(PhotoObject *)otherPhotoObject {
    return [self.photoSubject compare:otherPhotoObject.photoSubject];
}

-(NSComparisonResult)compareBasedOnLocation:(PhotoObject *)otherPhotoObject {
    return [self.photoTakenLocation compare:otherPhotoObject.photoTakenLocation];
}

@end
