//
//  NSString+Random.h
//  SearchTest
//
//  Created by supermacho on 19.10.16.
//  Copyright © 2016 supermacho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString*) randomAlphanumericString;

+ (NSString *) randomStringWithLength: (int) len;

@end
