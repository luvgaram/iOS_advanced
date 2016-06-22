//
//  NSString+Additional.h
//  w2_category
//
//  Created by Eunjoo Im on 2016. 6. 22..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)

- (NSString *)urlencode;
- (NSString *)urldecode;
- (NSArray *)filterHangulWord;

@end
