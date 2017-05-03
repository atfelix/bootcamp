//
//  main.m
//  ContactList
//
//  Created by atfelix on 2017-05-02.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Contact.h"
#import "ContactList.h"

@class InputCollector;
@class PhoneNumber;

void enqueue(NSMutableArray <NSString *> *queue, NSString *item) {
    queue[2] = queue[1];
    queue[1] = queue[0];
    queue[0] = item;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSMutableString *promptString = [[NSMutableString alloc] initWithString:@"What do you want to do next?\n\n"];
        [promptString appendString:@"\t\tnew - Create a new contact list\n"];
        [promptString appendString:@"\t\tlist - List all contacts\n"];
        [promptString appendString:@"\t\tshow (#) - Display Contact #\n"];
        [promptString appendString:@"\t\tfind string - Display all contacts with string in name or email\n"];
        [promptString appendString:@"\t\tadd - Add a Phone number to a contact\n"];
        [promptString appendString:@"\t\thistory - See last (at most) 3 commands\n"];
        [promptString appendString:@"\t\tquit - Exit Application\n"];

        InputCollector *input = [[InputCollector alloc] init];
        ContactList *contactsList = [[ContactList alloc] init];
        NSMutableArray <NSString *> *lastCommands = [[NSMutableArray alloc] initWithArray:@[@"", @"", @""]];

        while (1) {

            NSString *inputString = [input inputFromPrompt:promptString];
            enqueue(lastCommands, inputString);

            if ([inputString isEqualToString:@"quit"]) {
                NSLog(@"Goodbye!");
                break;
            }
            else if ([inputString isEqualToString:@"new"]) {
                Contact *newContact = [[Contact alloc] initWithInputCollector:input];
                if (newContact) {
                    [contactsList addContact:newContact];
                }
            }
            else if ([inputString isEqualToString:@"list"]) {
                NSArray <Contact *> *contacts = contactsList.contacts;

                for (int i = 0; i < contacts.count; i++) {
                    NSLog(@"%@", [NSString stringWithFormat:@"%i:%@", i, contacts[i].fullname]);
                }
            }
            else if ([inputString hasPrefix:@"show "]) {
                NSString *splice = [inputString substringFromIndex:5];

                if (![InputCollector isValidInteger:splice]) {
                    NSLog(@"Please enter a number for the index");
                    continue;
                }

                int value = [splice intValue];

                if (value >= contactsList.contacts.count) {
                    NSLog(@"Contact cannot be found");
                    continue;
                }
                Contact *showContact = contactsList.contacts[value];
                NSLog(@"%@", showContact);
            }
            else if ([inputString hasPrefix:@"find "]) {
                NSString *splice = [inputString substringFromIndex:5];

                for (Contact *contact in [contactsList queryItemsMatchingString:splice]) {
                    NSLog(@"%@", contact);
                }
            }
            else if ([inputString isEqualToString:@"add"]) {
                NSString *indexString = [input inputFromPrompt:@"Enter Contact id: "];

                if (![InputCollector isValidInteger:indexString]) {
                    NSLog(@"Please enter a number for the index");
                    continue;
                }

                int value = [indexString intValue];

                if (value >= contactsList.contacts.count) {
                    NSLog(@"Contact cannot be found");
                    continue;
                }

                Contact *contact = contactsList.contacts[value];
                PhoneNumber *phoneNumber = [[PhoneNumber alloc] initWithInputCollector:input];

                if (phoneNumber) {
                    [contact addPhoneNumber:phoneNumber];
                }
            }
            else if ([inputString isEqualToString:@"history"]) {
                NSLog(@"Last %lu commands:\n\n", lastCommands.count);
                for (NSString *string in lastCommands) {
                    NSLog(@"%@", string);
                }
            }
            else {
                NSLog(@"Invalid option.  Please try again");
            }
        }
    }
    return 0;
}
