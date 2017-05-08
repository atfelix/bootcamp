//
//  ArtistManager.m
//  Artist
//
//  Created by atfelix on 2017-05-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ArtistManager.h"

#import "Artist.h"

@interface ArtistManager ()

@property (nonatomic) NSArray<Artist *> *artists;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation ArtistManager

- (instancetype)init {

    self = [super init];
    if (self) {
        _currentIndex = 0;
        _artists = @[
                        [[Artist alloc] initWithName:@"Iggy Pop"
                                           imageName:@"iggy_p.jpg"],
                        [[Artist alloc] initWithName:@"Justin Bieber"
                                           imageName:@"justin_b.jpg"],
                        [[Artist alloc] initWithName:@"Taylor Swift"
                                           imageName:@"taylor_s.jpg"]
                    ];
    }
    return self;
}

-(void) randomNumber {
    NSUInteger randomizedNumber = arc4random_uniform((uint32_t)self.artists.count);

    if (randomizedNumber == self.currentIndex) {
        [self randomNumber];
    }
    else {
        self.currentIndex = randomizedNumber;
    }
}

-(Artist *)randomArtist {
    [self randomNumber];
    return self.artists[self.currentIndex];
}

@end
