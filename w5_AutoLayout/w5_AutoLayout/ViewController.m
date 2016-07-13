//
//  ViewController.m
//  w5_AutoLayout
//
//  Created by Eunjoo Im on 2016. 7. 13..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *splitView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraintHeight;


@end

@implementation ViewController

float firstX;
float firstY;
float screenWidth;
float screenHeight;
float splitHeight = 24.0;
float minimumHeight = 80.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSplitView:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_splitView addGestureRecognizer:panRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    NSLog(@"width: %f", screenWidth);
    NSLog(@"height: %f", screenHeight);
}
- (void)moveSplitView:(id)sender {
    [_splitView bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] frame].origin.y;
        translatedPoint = CGPointMake(firstX + translatedPoint.x, firstY);
    }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        CGFloat changeY = [(UIPanGestureRecognizer*)sender locationInView:self.view].y;
        CGFloat finalY = changeY;
            
        if (finalY < minimumHeight) {
            finalY = minimumHeight;
        } else if (finalY > screenHeight - minimumHeight) {
            finalY = screenHeight - minimumHeight;
        }
        _topViewConstraintHeight.constant = finalY;

    }
}

@end
