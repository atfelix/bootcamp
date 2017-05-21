//
//  PhotoObject.h
//  InstaKilo
//
//  Created by atfelix on 2017-05-21.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoObject : NSObject

@property (nonatomic) NSString *photoTakenLocation;
@property (nonatomic) NSString *photoSubject;
@property (nonatomic) NSString *photoFilename;

-(instancetype)initWithLocation:(NSString *)location andSubject:(NSString *)subject andFilename:(NSString *)filename;
-(NSComparisonResult)compareBasedOnLocation:(PhotoObject *)otherPhotoObject;
-(NSComparisonResult)compareBasedOnSubject:(PhotoObject *)otherPhotoObject;

@end
