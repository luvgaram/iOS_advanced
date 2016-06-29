//
//  NSString+Additional.m
//  w2_category
//
//  Created by Eunjoo Im on 2016. 6. 22..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NSString+Additional.h"

@implementation NSString (Additional)


- (NSString *)urlencode {
    NSString *encodedString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedString;
}

- (NSString *)urldecode {
    NSString *decodedString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decodedString;
}

- (NSArray *)filterHangulWord {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
//    NSCharacterSet *validCharacters = [NSCharacterSet characterSetWithCharactersInString:@" +abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/.?"];
//    NSCharacterSet *invalidCharacters = [validCharacters invertedSet];
//    NSRange invalidRange;
    NSArray *splicedResult = [[self mutableCopy] componentsSeparatedByString:@"-"];
    
    for (NSString *target in splicedResult) {
        NSMutableString *dest = [target mutableCopy];
        NSMutableString *intermediateString = [[NSMutableString alloc] init];
        
        unichar theChar = [dest characterAtIndex:0];
        
        for (int i = 0; i < dest.length; i++) {
            theChar = [dest characterAtIndex:i];
            
            if (theChar < 44032 || theChar > 55147) {
                continue;
            }
            
            [intermediateString appendString:[NSString stringWithFormat:@"%@", [NSString stringWithCharacters:&theChar length:1]]];
        }
        
        if ([intermediateString length] != 0) [resultArray addObject:intermediateString];
        
//        while ((invalidRange = [dest rangeOfCharacterFromSet:invalidCharacters]).length != 0) {
//            NSString *candidateString = [dest substringWithRange:invalidRange];
//            [intermediateString appendString:candidateString];
//            
//
//            [dest replaceCharactersInRange:invalidRange withString:@""];
//        }
//
//        if ([intermediateString length] != 0) [resultArray addObject:intermediateString];
    }
    
    return resultArray;
}

@end
