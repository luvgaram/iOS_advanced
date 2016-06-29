//
//  ViewController.m
//  w2_category
//
//  Created by Eunjoo Im on 2016. 6. 22..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Additional.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *urlPath;

- (IBAction)buttonClicked:(id)sender {
    NSURL *url = [NSURL URLWithString:urlPath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"Error,%@", [error localizedDescription]);
        } else {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            NSLog(@"%@", result);
            
            // truncate result
            NSRange stringRange = {0, MIN(result.length, 300)};
            stringRange = [result rangeOfComposedCharacterSequencesForRange:stringRange];
            NSString *shortString = [result substringWithRange:stringRange];
            
            UIAlertController * alert= [UIAlertController
                                        alertControllerWithTitle:@"Request result"
                                        message:shortString
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (IBAction)filterClicked:(id)sender {
    
    NSString *urlPathForFilter = @"http://www.osxdev.org/forum/index.php?threads/swift-2-0에서-try-catch로-fatal-error-잡을-수-있나요.382/";
    
    NSArray *resultArray = [urlPathForFilter filterHangulWord];
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [resultArray count]; i++) {
        [resultString appendString:resultArray[i]];
        if (i != [resultArray count] - 1) [resultString appendString:@", "];
    }
    
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:@"Filter result"
                                message:resultString
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    urlPath = @"http://www.osxdev.org/forum/index.php?threads/ios8-에서-webgl-지원.356/";
    urlPath = [urlPath urlencode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
