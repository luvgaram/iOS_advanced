//
//  SetupViewController.m
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SetupViewController.h"

@implementation SetupViewController

NSInteger dayCount;
NSDate *selectedDate;
NSDate *selectedTime;
NSString *selectedTimeString;

- (void)viewDidLoad {
    [_datePicker addTarget:self action:@selector(dateDidChange) forControlEvents:UIControlEventValueChanged];
    [_timePicker addTarget:self action:@selector(timeDidChange) forControlEvents:UIControlEventValueChanged];
}

- (void)dateDidChange {
    selectedDate = _datePicker.date;
    dayCount = [self countDate:selectedDate];
}

- (void)timeDidChange {
    selectedTime = _timePicker.date;
    selectedTimeString = [self countTime:selectedTime];
}

- (IBAction)doneButtonTapped:(id)sender {
    NSUserDefaults *myPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    
    [myPrefs setInteger:dayCount forKey:@"dayCount"];
    [myPrefs setObject:[self stringFromDate:selectedDate] forKey:@"targetDate"];
    [myPrefs setObject:selectedTimeString forKey:@"timeCount"];
    [myPrefs setObject:[self timeStringFromDate:selectedTime] forKey:@"targetTime"];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSString *)countTime:(NSDate *)targetDate {
    NSDate *now = [NSDate date];
    
    NSDateComponents *conversionInfo = [self componentsFrom:now To:targetDate];
    
    NSInteger hour = [conversionInfo hour];
    NSInteger minute = [conversionInfo minute];
    
    NSLog(@"hour: %d, minute: %d", hour, minute);
    
    if (minute > 9 || minute < -9)
        return [NSString stringWithFormat:@"%d:%d", hour, minute];
    else
        return [NSString stringWithFormat:@"%d:0%d", hour, minute];
}

- (int)countDate:(NSDate *)targetDate {
    NSDate *startOfToday = [self midnightOfDate:[NSDate date]];
    NSDate *startOfTargetDate = [self midnightOfDate:targetDate];
    
    NSDateComponents *conversionInfo = [self componentsFrom:startOfTargetDate To:startOfToday];
    
    return [conversionInfo day];
}

- (NSDate *)midnightOfDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] startOfDayForDate:date];
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)timeStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:string];
}

- (NSDateComponents *)componentsFrom:(NSDate *)startDate To:(NSDate *)endDate {
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
        
    //    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay;
        
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
        
    NSLog(@"Conversion: %dmin %dhours %ddays",[conversionInfo minute], [conversionInfo hour], [conversionInfo day]);
        
    return conversionInfo;
}
@end
