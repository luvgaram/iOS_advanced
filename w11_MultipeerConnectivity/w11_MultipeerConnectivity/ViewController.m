//
//  ViewController.m
//  w11_MultipeerConnectivity
//
//  Created by Eunjoo Im on 2016. 8. 24..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serviceField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation ViewController

bool isServiceTyped;
bool isNameTyped;
GameViewController *gameViewController;

- (IBAction)serviceFieldEdited:(id)sender {
    if (_serviceField.text.length > 1) {
        isServiceTyped = YES;
        
        if (isNameTyped)
            _doneButton.enabled = YES;
    }
}
- (IBAction)nameFieldEdited:(id)sender {
    if (_nameField.text.length > 1) {
        isNameTyped = YES;
        
        if (isServiceTyped)
            _doneButton.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isServiceTyped = _serviceField.text.length > 1 ? YES : NO;
    isNameTyped  = _nameField.text.length > 1 ? YES : NO;
    
    _doneButton.enabled = (isServiceTyped && isNameTyped) ? YES : NO;
    
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGameView"]) {
        gameViewController = segue.destinationViewController;
        gameViewController.serviceType = _serviceField.text;
        gameViewController.displayName = _nameField.text;
        
        [self createSession];

    }
    NSLog(@"gameViewController: %@", gameViewController);
}

- (void)createSession {
    
    NSLog(@"newSessionContainer service : %@, name: %@", _serviceField.text, _nameField.text);
    SessionContainer *newSessionContainer = [[SessionContainer alloc] initWithDisplayName:_nameField.text serviceType:_serviceField.text];
    gameViewController.sessionContainer = newSessionContainer;
}

@end
