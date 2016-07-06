//
//  EJAnimatorDelegator.m
//  w4_customTransition
//
//  Created by Eunjoo Im on 2016. 7. 6..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJAnimatorDelegator.h"
#import "FlipPresentAnimator.h"

@implementation EJAnimatorDelegator

- (id)initWithViewController: (UIViewController *)viewController; {
    self = [super init];
    if (self) {
        [viewController.navigationController setDelegate:self];
    }
    return self;
}

# pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    FlipPresentAnimator *animator = [FlipPresentAnimator new];

    return (id)animator;
}

@end
