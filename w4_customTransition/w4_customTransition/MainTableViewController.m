//
//  MainTableViewController.m
//  w4_customTransition
//
//  Created by Eunjoo Im on 2016. 7. 6..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MainTableViewController.h"
#import "TransitionAnimator.h"

@interface MainTableViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *secondCell;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setDelegate:self];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(secondCellTapped:)];
    [_secondCell addGestureRecognizer:recognizer];
}

- (void)secondCellTapped:(UITapGestureRecognizer *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle: nil];
    
    UIViewController* newvc = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];

    [self.navigationController pushViewController:newvc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *nextViewController = [segue destinationViewController];
    nextViewController.transitioningDelegate = (id)self;
    nextViewController.modalPresentationStyle = UIModalPresentationCustom;
    
}

# pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    TransitionAnimator *animator = [TransitionAnimator new];
    animator.presenting = YES;
    animator.navigating = NO;
    
    NSLog(@"main present");
    
    return (id)animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    id<UIViewControllerAnimatedTransitioning> animationController;

    TransitionAnimator *animator = [TransitionAnimator new];
    animator.presenting = NO;
    animator.navigating = NO;
    
    NSLog(@"main dismiss");
    return animationController;
}

# pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    TransitionAnimator *animator = [TransitionAnimator new];
    animator.navigating = YES;
    animator.presenting = (operation == UINavigationControllerOperationPush);
    
    NSLog(@"navigation");
    return (id)animator;
}

@end
