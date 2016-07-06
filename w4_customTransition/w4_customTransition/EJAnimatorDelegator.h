//
//  EJAnimatorDelegator.h
//  w4_customTransition
//
//  Created by Eunjoo Im on 2016. 7. 6..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EJAnimatorDelegator : NSObject<UINavigationControllerDelegate>

- (id)initWithViewController: (UIViewController *)viewController;

@end
