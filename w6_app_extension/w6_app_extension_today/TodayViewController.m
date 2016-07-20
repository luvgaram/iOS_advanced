//
//  TodayViewController.m
//  w6_app_extension_today
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "EJDateManager.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EJDateManager *dateManager = [[EJDateManager alloc] init];
    
    NSUserDefaults *myPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    
    NSDate *targetDate = [myPrefs objectForKey:@"targetDate"];
    
    if (targetDate) {
        NSDateComponents *components = [dateManager componentsFrom:targetDate];
        
        _todayDayCountLabel.text = [dateManager countDays:components];
        _todayTargetDateLabel.text = [dateManager dayString:targetDate];
        _todayTimeCountLabel.text = [dateManager countTime:components];
        _todayTargetTimeLabel.text = [dateManager timeString:targetDate];
    }
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
