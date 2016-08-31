//
//  ViewController.m
//  w12_Localization
//
//  Created by Eunjoo Im on 2016. 8. 31..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;

@end

@implementation ViewController
- (IBAction)birthdayButtonTapped:(id)sender {
    NSString *birthdayString = NSLocalizedStringFromTable(@"BIRTHDAY", @"localizable", nil);
    
    NSString *regionCode = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
    NSLog(@"%@", regionCode);

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthday = [dateFormatter dateFromString: birthdayString];
    
    NSString *dateFormat = NSLocalizedStringFromTable(@"STYLE", @"localizable", nil);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:dateFormat];
    NSString *dateString = [df stringFromDate:birthday];

    [_birthdayButton setTitle:dateString forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
