//
//  NSString+Random.m
//  SearchTest
//
//  Created by supermacho on 19.10.16.
//  Copyright © 2016 supermacho. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)


+ (NSString*) randomAlphanumericString {
    int length = (arc4random() % 11) + 5;
    
    return [self randomStringWithLength:length];
}

+ (NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";//ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % ([letters length])]];
    }
    
    return randomString;
}

@end
