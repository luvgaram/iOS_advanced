//
//  EJDateManager.h
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJDateManager : NSObject

- (NSDateComponents *)componentsFrom:(NSDate *)date;
- (NSString *)dayString:(NSDate *)date;
- (NSString *)timeString:(NSDate *)date;
- (NSString *)countDays:(NSDateComponents *)components;
- (NSString *)countTime:(NSDateComponents *)components;

@end
