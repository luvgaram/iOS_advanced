//
//  CalendarViewController.m
//  w3_XIBProblem
//
//  Created by Eunjoo Im on 2016. 6. 29..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

CGFloat windowWidth;
CGFloat windowHeight;

int margin = 10;
int buttonWidth = 20;
int buttonHeight = 10;

float marginWidth;
float marginHeight;

int year = 2016;
int month = 7;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setMeasures];
    [self setCalendar];
}

- (void)setMeasures {
    CGRect windowRect = self.view.frame;
    windowWidth = windowRect.size.width;
    windowHeight = windowRect.size.height;
    
    marginWidth = (windowWidth - margin - (buttonWidth * 7)) / 8.0;
    marginHeight = (windowHeight - margin - (buttonHeight * 5)) / 8.0;
}

- (void)setTitle {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((windowWidth - 50) / 2, marginHeight / 2, 100, 20)];
    label.textColor = [UIColor blackColor];
    label.backgroundColor=[UIColor clearColor];
    label.userInteractionEnabled = NO;
    label.text = [NSString stringWithFormat:@"%d년 %d월", year, month];
    [self.view addSubview:label];
}

- (void)setButton {
    UIButton *previousMonthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    previousMonthButton.frame = CGRectMake(margin, marginHeight / 2, buttonWidth * 2, buttonHeight * 2);
    [previousMonthButton setTitle:@"<-" forState:UIControlStateNormal];
    
    [self.view addSubview:previousMonthButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previousButtontapped:)];
    [previousMonthButton addGestureRecognizer:tap];
    
    UIButton *nextMonthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextMonthButton.frame = CGRectMake(windowWidth - margin - buttonWidth * 2, marginHeight / 2, buttonWidth * 2, buttonHeight * 2);
    [nextMonthButton setTitle:@"->" forState:UIControlStateNormal];
    
    [self.view addSubview:nextMonthButton];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtontapped:)];
    [nextMonthButton addGestureRecognizer:tap];
}

- (void)previousButtontapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%@", @"previous tapped");
    if (month == 1) {
        month = 12;
        year--;
    } else month--;
    
    [self setCalendar];
}

- (void)nextButtontapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%@", @"next tapped");
    if (month == 12) {
        month = 1;
        year++;
    } else month++;
    
    [self setCalendar];
}

- (void)removeSubviews {
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *view in viewsToRemove) {
        [view removeFromSuperview];
    }
}

- (void)setCalendar {
    [self removeSubviews];
    [self setTitle];
    [self setButton];
    
    NSString *dateStr;
    if (month < 10) dateStr = [NSString stringWithFormat:@"%d%@%d%@", year, @"0", month, @"01"];
    else dateStr = [NSString stringWithFormat:@"%d%d%@", year, month, @"01"];
    
    NSLog(@"date: %@", dateStr);
    float startX = margin + marginWidth;
    float startY = margin + marginHeight;
    
    NSArray *weekday = @[@"일", @"월", @"화", @"수", @"목", @"금", @"토"];
    UIButton *newButton;
    
    for (int i = 0; i < 7; i++) {
        newButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        newButton.frame = CGRectMake(startX, startY, buttonWidth, buttonHeight);
        [newButton setTitle:weekday[i] forState:UIControlStateNormal];
        
        [self.view addSubview:newButton];
        
        startX += (buttonWidth + marginWidth);
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [currentCalendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDay = [dateComponents weekday] - 1;
    
    NSRange days = [currentCalendar rangeOfUnit:NSCalendarUnitDay
                                         inUnit:NSCalendarUnitMonth
                                        forDate:date];
    
    int measure = days.length;
    
    startX = marginWidth + (buttonWidth + marginWidth) * weekDay;
    startY = buttonHeight + marginHeight * 2;
    
    for (int i = 0; i < measure; i++) {
        newButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        newButton.frame = CGRectMake(startX, startY, buttonWidth, buttonHeight);
        [newButton setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        
        [self.view addSubview:newButton];
        
        if ((weekDay + i % 7) == 6) {
            startX = marginWidth;
            startY += marginHeight + buttonHeight;
        }
        else startX += (buttonWidth + marginWidth);
    }
}


@end
