//
//  ViewController.m
//  w9_Keychain
//
//  Created by Eunjoo Im on 2016. 8. 10..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "DictionarySerializationModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *insertName;
@property (weak, nonatomic) IBOutlet UITextField *insertNumber;
@property (weak, nonatomic) IBOutlet UITextField *deleteNumber;

@end

@implementation ViewController

DictionarySerializationModel *studentModel;
NSData *data;


- (IBAction)addButtonTapped:(id)sender {
    [studentModel readFromKeychain];
    
    NSString *name = _insertName.text;
    NSString *number = _insertNumber.text;
    
    if (name.length > 0 && number.length > 0) {
        [studentModel addStudentWithNumber:number andName: name];
        _insertName.text = @"";
        _insertNumber.text = @"";
        
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"입력 불가"
                                     message:@"이름과 학번을 모두 입력해 주세요."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
    [studentModel writeToKeychain];
}
- (IBAction)deleteButtonTapped:(id)sender {
    [studentModel readFromKeychain];
    
    NSString *number = _deleteNumber.text;
    
    if (number.length > 0) {
        [studentModel deleteStudentWithNumber:number];
        _deleteNumber.text = @"";
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"삭제 불가"
                                     message:@"학번을 입력해 주세요."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
    [studentModel writeToKeychain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    studentModel = [[DictionarySerializationModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
