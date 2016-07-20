//
//  SetupViewController.m
//  w6_app_extension
//
//  Created by Eunjoo Im on 2016. 7. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SetupViewController.h"

@implementation SetupViewController

NSString *dayCount;
NSDate *selectedDate;

- (void)viewDidLoad {
    [_datePicker addTarget:self action:@selector(dateDidChange) forControlEvents:UIControlEventValueChanged];
}

- (void)dateDidChange {
    selectedDate = _datePicker.date;
}


- (IBAction)doneButtonTapped:(id)sender {
    NSUserDefaults *myPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.jayIm"];
    [myPrefs setObject:selectedDate forKey:@"targetDate"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
