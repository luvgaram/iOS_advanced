//
//  PopUpViewController.m
//  w4_customTransition
//
//  Created by Eunjoo Im on 2016. 7. 6..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "PopUpViewController.h"
#import "TransitionAnimator.h"
#import "MainTableViewController.h"

@interface PopUpViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MainTableViewController *mainViewController = [segue destinationViewController];
    mainViewController.transitioningDelegate = (id)self;
    mainViewController.modalPresentationStyle = UIModalPresentationCustom;
}

# pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    TransitionAnimator *animator = [TransitionAnimator new];
    animator.presenting = NO;
    animator.navigating = NO;
    
    NSLog(@"popup dismiss");
    return (id)animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    TransitionAnimator *animator = [TransitionAnimator new];
    animator.presenting = YES;
    animator.navigating = NO;
    
    NSLog(@"popup not to do");
    return (id)animator;
}

@end
