//
//  ViewController.m
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "EJDateManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetTimeLabel;

@end

@implementation ViewController

EJDateManager *dateManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    dateManager = [[EJDateManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *myPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    
    NSDate *targetDate = [myPrefs objectForKey:@"targetDate"];
    
    if (targetDate) {
        NSDateComponents *components = [dateManager componentsFrom:targetDate];

        _dayCountLabel.text = [dateManager countDays:components];
        _timeCountLabel.text = [dateManager countTime:components];
        _targetDayLabel.text = [dateManager dayString:targetDate];
        _targetTimeLabel.text = [dateManager timeString:targetDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
