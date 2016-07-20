//
//  TodayViewController.h
//  w6_app_extension_today
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *todayDayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTargetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTimeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTargetTimeLabel;

@end
