//
//  main.m
//  WordEffects
//
//  Created by atfelix on 2017-05-01.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_CHARS 255

/*
 * readline: reads a line from the standard input and stores it in to
 *           string.  It does not store newline characters.  It terminates
 *           string with a null terminator. It stores the value of the 
 *           converted number inside *number.
 */

int readline(char *string, int numChars) {

    char ch;
    int numReadChars = 0;

    while ((ch = getc(stdin)) != EOF && (ch != '\n')) {
        if (numReadChars < numChars) {
            string[numReadChars++] = ch;
        }
    }
    string[numReadChars] = '\0';
    return numReadChars;
}

BOOL convertStringToNumber(NSString *string, double *number) {

    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    BOOL foundPeriod = NO;
    int start = 0, sign = 1;
    double exponentialFactor = 0.1;

    *number = 0.0;

    // Find sign (strings can start with -/+).  If it starts with - or +, then we adjust start to 1

    if ([string characterAtIndex:0] == '-') {
        sign = -1;
        start = 1;
    }
    else if ([string characterAtIndex:0] == '+') {
        sign = 1;
        start = 1;
    }

    // Scan string for illegal characters. Otherwise modify *number accordingly.

    for (int i = start; i < string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (![charSet characterIsMember:ch]) {
            *number = 0.0;
            return NO;
        }

        if (ch == '.') {
            if (foundPeriod) {
                *number = 0.0;
                return NO;
            }
            foundPeriod = YES;
            continue;
        }

        if (foundPeriod) {
            *number = *number + (ch - '0') * exponentialFactor;
            exponentialFactor /= 10.0;
        }
        else {
            *number = *number * 10 + (ch - '0');
        }
    }
    *number *= sign;
    return YES;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        while (YES) {

            char inputChars[MAX_CHARS];

            printf("Input a string: ");

            if (readline(inputChars, MAX_CHARS - 1) == 0) {
                printf("There was an error in reading.\n");
                exit(EXIT_FAILURE);
            }

            printf("Input was :%s\n", inputChars);
            NSString *inputString = [NSString stringWithUTF8String:inputChars];

            char operationString[2];
            int operationNumber;

            printf("========================================================\n");
            printf("\n1: Uppercase (prints uppercase version of your string)\n");
            printf("2: Lowercase (prints lowercase version of your string)\n");
            printf("3: Numberize (Converts your string to a number if possible)\n");
            printf("4: Canadianize (prints your string with \", eh?\" appended)\n");
            printf("5: Respond (prints response to a question or an excited statement)\n");
            printf("6: Despace-It (replaces spaces with hyphens)\n");
            printf("========================================================\n\n");
            printf("Please enter an operation number (1, 2, 3, 4, 5, 6): ");

            if (readline(operationString, 2) != 1) {
                printf("There was an error in reading.\n");
                exit(EXIT_FAILURE);
            }

            sscanf(operationString, "%d", &operationNumber);

            double convertedNumber;
            
            switch (operationNumber) {
                case 1: NSLog(@"%@", [inputString uppercaseString]); break;

                case 2: NSLog(@"%@", [inputString lowercaseString]); break;

                case 3:
                    if (convertStringToNumber(inputString, &convertedNumber)) {
                        NSLog(@"Converted Number: %f\n", convertedNumber);
                    }
                    else {
                        NSLog(@"Number could not be converted.");
                    }
                    break;

                case 4: NSLog(@"%@", [inputString stringByAppendingString:@", eh?"]); break;

                case 5:
                    if ([inputString hasSuffix:@"?"]) {
                        NSLog(@"I don't know");
                    }
                    else if ([inputString hasSuffix:@"!"]) {
                        NSLog(@"Whoa, calm down");
                    }
                    break;

                case 6:
                    NSLog(@"%@", [inputString stringByReplacingOccurrencesOfString:@" "
                                                                        withString:@"-"]);
                    break;
                default: NSLog(@"Invalid codebreak"); break;
            }
        }
    }
    return 0;
}
