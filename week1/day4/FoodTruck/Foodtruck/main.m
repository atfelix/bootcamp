//
//  main.m
//  FoodTruck
//
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FoodTruck.h"
#import "Cook.h"
#import "Chef.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        FoodTruck *truckA = [[FoodTruck alloc] initWithName:@"Take a Bao" andFoodType:@"bao"];
        
        FoodTruck *truckB = [[FoodTruck alloc] initWithName:@"Tim Shortons" andFoodType:@"shortbread"];
        
        // create instances of your delegate class
        // set truckA and truckB's delegate to your new instance.

//        Cook *cookA = [[Cook alloc] init];
//        Cook *cookB = [[Cook alloc] init];
//
//
//        truckA.delegate = cookA;
//        truckB.delegate = cookB;

        Chef *chefA = [[Chef alloc] init];
        Chef *chefB = [[Chef alloc] init];

        truckA.delegate = chefA;
        truckB.delegate = chefB;

        [truckA serve:10];
        [truckB serve:5];
        
        [truckA cashOut];
        [truckB cashOut];

    }
    return 0;
}
