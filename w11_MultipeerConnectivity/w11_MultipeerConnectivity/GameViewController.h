//
//  GameViewController.h
//  w11_MultipeerConnectivity
//
//  Created by Eunjoo Im on 2016. 8. 24..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionContainer.h"

@interface GameViewController : UIViewController

@property NSString *serviceType;
@property NSString *displayName;
@property SessionContainer *sessionContainer;
//@property NSMutableArray *transcripts;

@end
