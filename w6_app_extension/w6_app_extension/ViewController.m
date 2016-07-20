//
//  ViewController.m
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetTimeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *myPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    NSInteger dayCount = [myPrefs integerForKey:@"dayCount"];
    NSString *timeCount = [myPrefs objectForKey:@"timeCount"];
    NSString *targetDate = [myPrefs objectForKey:@"targetDate"];
    NSString *targetTime = [myPrefs objectForKey:@"targetTime"];
    _dayCountLabel.text = [NSString stringWithFormat:@"%d", dayCount];
    _timeCountLabel.text = timeCount;
    _targetDayLabel.text = targetDate;
    _targetTimeLabel.text = targetTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
