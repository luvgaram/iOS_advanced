//
//  EJDateManager.m
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDateManager.h"

@implementation EJDateManager

- (NSDateComponents *)componentsFrom:(NSDate *)date {
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];

    //    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date  toDate:[NSDate date]  options:0];
    
    NSLog(@"Conversion: %dmin %dhours %ddays",[conversionInfo minute], [conversionInfo hour], [conversionInfo day]);
    
    return conversionInfo;
}

- (NSString *)dayString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)timeString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)countDays:(NSDateComponents *)components {
    return [NSString stringWithFormat:@"%d", [components day]];
}

- (NSString *)countTime:(NSDateComponents *)components {
    
    int hour = abs([components hour]);
    int minute = abs([components minute]);
    
    if (minute < 10)
        return [NSString stringWithFormat:@"%d:0%d", hour, minute];
    else return [NSString stringWithFormat:@"%d:%d", hour, minute];
}

@end
