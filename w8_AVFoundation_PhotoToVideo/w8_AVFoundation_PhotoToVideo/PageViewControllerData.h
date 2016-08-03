//
//  AppDelegate.h
//  w8_AVFoundation_PhotoToVideo
//
//  Created by Eunjoo Im on 2016. 8. 3..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewControllerData : NSObject

+ (PageViewControllerData *)sharedInstance;

@property (nonatomic, strong) NSArray *photoAssets; // array of ALAsset objects

- (NSUInteger)photoCount;
- (UIImage *)photoAtIndex:(NSUInteger)index;

@end