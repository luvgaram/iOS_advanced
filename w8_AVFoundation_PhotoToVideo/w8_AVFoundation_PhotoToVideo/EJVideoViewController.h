//
//  EJVideoViewController.h
//  w8_AVFoundation_PhotoToVideo
//
//  Created by Eunjoo Im on 2016. 8. 3..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EJVideoViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *photoAssets;
@property (nonatomic, strong) NSMutableArray *targetIndexPaths;

@end
