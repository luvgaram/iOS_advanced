//
//  TodayViewController.m
//  w6_app_extension_today
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *myPref = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    
    NSInteger dayCount = [myPref integerForKey:@"dayCount"];
    NSString *timeCount = [myPref objectForKey:@"timeCount"];
    NSString *targetDate = [myPref objectForKey:@"targetDate"];
    NSString *targetTime = [myPref objectForKey:@"targetTime"];
    
    _todayDayCountLabel.text = [NSString stringWithFormat:@"%d", dayCount];
    _todayTargetDateLabel.text = targetDate;
    _todayTimeCountLabel.text = timeCount;
    _todayTargetTimeLabel.text = targetTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
