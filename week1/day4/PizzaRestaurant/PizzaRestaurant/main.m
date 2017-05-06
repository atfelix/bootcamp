//
//  main.m
//  PizzaRestaurant
//
//  Created by Steven Masuch on 2014-07-19.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Kitchen.h"
#import "AnchoviesHatingManager.h"
#import "CheeryManager.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSLog(@"Please pick your pizza size and toppings:");
        
        Kitchen *restaurantKitchen1 = [[Kitchen alloc] init];
        Kitchen *restaurantKitchen2 = [[Kitchen alloc] init];

        AnchoviesHatingManager *manager1 = [[AnchoviesHatingManager alloc] init];
        CheeryManager *manager2 = [[CheeryManager alloc] init];

        restaurantKitchen1.delegate = manager1;
        restaurantKitchen2.delegate = manager2;
        
        while (TRUE) {
            // Loop forever
            
            NSLog(@"> ");
            char str[100];
            fgets (str, 100, stdin);
            
            NSString *inputString = [[NSString alloc] initWithUTF8String:str];
            inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            NSLog(@"Input was %@", inputString);
            
            // Take the first word of the command as the size, and the rest as the toppings
            NSArray *commandWords = [inputString componentsSeparatedByString:@" "];
            
            // And then send some message to the kitchen...
            NSLog(@"%@",
                  [restaurantKitchen1 makePizzaWithSize:commandWords[0]
                                               toppings:[commandWords
                                                         subarrayWithRange:NSMakeRange(1, commandWords.count - 1)]]
                  );

            NSLog(@"%@",
                  [restaurantKitchen2 makePizzaWithSize:commandWords[0]
                                               toppings:[commandWords
                                                         subarrayWithRange:NSMakeRange(1, commandWords.count - 1)]]
                  );
        }
    }
    return 0;
}
