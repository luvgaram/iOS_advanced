//
//  FlipPresentAnimator.m
//  w4_customTransition
//
//  Created by Eunjoo Im on 2016. 7. 6..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "FlipPresentAnimator.h"

@implementation FlipPresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect originFrame = CGRectZero;
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:toViewController.view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;

    CATransform3D fromViewRotationPerspectiveTrans = CATransform3DIdentity;
    fromViewRotationPerspectiveTrans.m34 = -0.003; // 3D ish effect
    fromViewRotationPerspectiveTrans = CATransform3DRotate(fromViewRotationPerspectiveTrans, M_PI_2, 0.0f, -1.0f, 0.0f);
    
    // set up to
    CATransform3D toViewRotationPerspectiveTrans = CATransform3DIdentity;
    toViewRotationPerspectiveTrans.m34 = -0.003;
    toViewRotationPerspectiveTrans = CATransform3DRotate(toViewRotationPerspectiveTrans, M_PI_2, 0.0f, 1.0f, 0.0f);
    
    toViewController.view.layer.transform = toViewRotationPerspectiveTrans;
    
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{fromViewController.view.layer.transform = fromViewRotationPerspectiveTrans; }
                     completion:^(BOOL finished) {
                         
                         [fromViewController.view removeFromSuperview];
                         [UIView animateWithDuration:0.5f
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{toViewController.view.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 0.0);}
                                          completion:^(BOOL finished) {
                                                      toViewController.view.hidden = false;
                                                      fromViewController.view.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
                                                      [transitionContext completeTransition:YES];
                                                  }];
                         
                     }];

}

@end
