//
//  AppDelegate.h
//  w8_AVFoundation_PhotoToVideo
//
//  Created by Eunjoo Im on 2016. 8. 3..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "PageViewControllerData.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation PageViewControllerData

+ (PageViewControllerData *)sharedInstance {
    static dispatch_once_t onceToken;
    static PageViewControllerData *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PageViewControllerData alloc] init];
    });
    return sSharedInstance;
}

- (NSUInteger)photoCount {
    return self.photoAssets.count;
}

- (UIImage *)photoAtIndex:(NSUInteger)index {
    ALAsset *photoAsset = self.photoAssets[index];
    
    ALAssetRepresentation *assetRepresentation = [photoAsset defaultRepresentation];
    
    UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]
                                                   scale:[assetRepresentation scale]
                                             orientation:ALAssetOrientationUp];
    return fullScreenImage;
}

@end
