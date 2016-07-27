//
//  PersonAddViewController.m
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "PersonAddViewController.h"


@interface PersonAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *personAgeTextField;

@end

@implementation PersonAddViewController

PersonDataManager *addManager;

- (IBAction)submitButtonTapped:(id)sender {
    
    Person *targetPerson;
    
    if (_originalPerson)
        targetPerson = [self editOriginalPerson];
    else targetPerson = [self newPerson];
    
    if (_personAgeTextField.text.length != 0 && _personAgeTextField.text.length != 0) {
        targetPerson.name = _personNameTextField.text;
        targetPerson.age = [_personAgeTextField.text integerValue];
        
        [addManager addOrUpdatePerson:targetPerson];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataChanged" object:self];

        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (Person *)newPerson {
    Person *newPerson = [[Person alloc] init];
    newPerson.id = (NSInteger)[addManager getIdManager];
    return newPerson;
}

- (Person *)editOriginalPerson {
    Person *newPerson = [[Person alloc] init];
    newPerson.id = _originalPerson.id;
    return newPerson;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    addManager = [PersonDataManager sharedInstance];
    
    if (_originalPerson) {
        _personNameTextField.text = _originalPerson.name;
        _personAgeTextField.text = [NSString stringWithFormat:@"%d", _originalPerson.age];
    }
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
