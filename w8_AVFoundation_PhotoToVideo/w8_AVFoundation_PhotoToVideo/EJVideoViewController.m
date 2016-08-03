//
//  EJVideoViewController.m
//  w8_AVFoundation_PhotoToVideo
//
//  Created by Eunjoo Im on 2016. 8. 3..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJVideoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "EJPreviewView.h"
@import AVFoundation;

@interface EJVideoViewController()

@property (weak, nonatomic) IBOutlet EJPreviewView *previewView;
@property (nonatomic) dispatch_queue_t sessionQueue;
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) AVCaptureMovieFileOutput *movieFileOutput;

@end

@implementation EJVideoViewController

#pragma mark - View lifecycle

NSMutableArray *selectedPhotoAssets;
AVPlayerItem *playerItem;
AVPlayer *player;
NSURL *videoTempURL = NULL;

int height;
int width;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedImageArray];
    [self saveMovieToLibrary];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    dispatch_async( self.sessionQueue, ^{
        [self.session stopRunning];
    });
    
    [super viewDidDisappear:animated];
}

- (void)setSelectedImageArray {
    selectedPhotoAssets = [NSMutableArray array];
    
    for (NSIndexPath *indexPath in self.targetIndexPaths) {
        ALAsset *asset = self.photoAssets[indexPath.row];
        
        CGImageRef imageRef = CGImageCreateCopy(asset.defaultRepresentation.fullResolutionImage);
        UIImage *fullResolutionImage = [UIImage imageWithCGImage:imageRef];
        [selectedPhotoAssets addObject:fullResolutionImage];
        CGImageRelease(imageRef);
        
        NSLog(@"image: %@", fullResolutionImage);
    }
}

// http://stackoverflow.com/questions/3741323/how-do-i-export-uiimage-array-as-a-movie
- (void)saveMovieToLibrary {

//    height = ((UIImage *)selectedPhotoAssets[0]).size.height;
//    width = ((UIImage *)selectedPhotoAssets[0]).size.width;
    height = 600;
    width = 480;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *fileNameOut = [NSString stringWithFormat:@"%@.mov", [dateFormatter stringFromDate:[NSDate date]]];
    
    // We chose to save in the tmp/ directory on the device initially
    NSString *directoryOut = @"tmp/";
    NSString *outFile = [NSString stringWithFormat:@"%@%@",directoryOut,fileNameOut];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:outFile]];
    NSURL *videoTempURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fileNameOut]];
    
    // WARNING: AVAssetWriter does not overwrite files for us, so remove the destination file if it already exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[videoTempURL path]  error:NULL];
    
    
    // Create your own array of UIImages
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < [selectedPhotoAssets count]; i++) {
        // This was our routine that returned a UIImage. Just use your own.
        UIImage *image = [selectedPhotoAssets objectAtIndex:i];
        // We used a routine to write text onto every image
        // so we could validate the images were actually being written when testing. This was it below.
//        image = [self writeToImage:image Text:[NSString stringWithFormat:@"%i",i ]];
        [images addObject:image];
    }
    
    [self writeImageAsMovie:images toPath:path size:CGSizeMake(height, width)];
}

-(void)writeImageAsMovie:(NSArray *)array toPath:(NSString*)path size:(CGSize)size {
    
    NSError *error = nil;
    
    // FIRST, start up an AVAssetWriter instance to write your video
    // Give it a destination path (for us: tmp/temp.mov)
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:path]
                                                           fileType:AVFileTypeQuickTimeMovie
                                                              error:&error];
    
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:size.height], AVVideoHeightKey,
                                   nil];
    
    AVAssetWriterInput* writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                                         outputSettings:videoSettings];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                                                                                     sourcePixelBufferAttributes:nil];
    NSParameterAssert(writerInput);
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    [videoWriter addInput:writerInput];
    
    
    //Start a SESSION of writing.
    // After you start a session, you will keep adding image frames
    // until you are complete - then you will tell it you are done.
    [videoWriter startWriting];
    // This starts your video at time = 0
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    CVPixelBufferRef buffer = NULL;
    
    int i = 0;
    while (1) {
        // Check if the writer is ready for more data, if not, just wait
        if (writerInput.readyForMoreMediaData){
            
            float framePerPhoto = 3 * 600 / [selectedPhotoAssets count];
            
            CMTime frameTime = CMTimeMake(framePerPhoto, 600);
            // CMTime = Value and Timescale.
            // Timescale = the number of tics per second you want
            // Value is the number of tics
            // For us - each frame we add will be 1/4th of a second
            // Apple recommend 600 tics per second for video because it is a
            // multiple of the standard video rates 24, 30, 60 fps etc.
            CMTime lastTime = CMTimeMake(i * framePerPhoto, 600);
            CMTime presentTime = CMTimeAdd(lastTime, frameTime);
            
            if (i == 0) {presentTime = CMTimeMake(0, 600);}
            // This ensures the first frame starts at 0.
            
            
            if (i >= [array count]) {
                buffer = NULL;
            } else {
                // This command grabs the next UIImage and converts it to a CGImage
                buffer = [self pixelBufferFromCGImage:[[array objectAtIndex:i] CGImage]];
            }
            
            
            if (buffer) {
                // Give the CGImage to the AVAssetWriter to add to your video
                [adaptor appendPixelBuffer:buffer withPresentationTime:presentTime];
                i++;
            } else { //Finish the session:
                // This is important to be done exactly in this order
                [writerInput markAsFinished];
                // WARNING: finishWriting in the solution above is deprecated.
                // You now need to give a completion handler.
                [videoWriter finishWritingWithCompletionHandler:^{
                    NSLog(@"Finished writing...checking completion status...");
                    if (videoWriter.status != AVAssetWriterStatusFailed
                        && videoWriter.status == AVAssetWriterStatusCompleted) {
                        NSLog(@"Video writing succeeded.");
                        
                        // Move video to camera roll
                        // NOTE: You cannot write directly to the camera roll.
                        // You must first write to an iOS directory then move it!
                        videoTempURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@", path]];
                        [self saveToCameraRoll:videoTempURL];
                        
                        [self loadAssetFromFile];
                        
                    } else {
                        NSLog(@"Video writing failed: %@", videoWriter.error);
                    }
                    
                }]; // end videoWriter finishWriting Block
                
                CVPixelBufferPoolRelease(adaptor.pixelBufferPool);
                
                NSLog (@"Done");
                break;
            }
        }
    }    
}

- (void)saveToCameraRoll:(NSURL *)srcURL {
    NSLog(@"srcURL: %@", srcURL);
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    ALAssetsLibraryWriteVideoCompletionBlock videoWriteCompletionBlock =
    ^(NSURL *newURL, NSError *error) {
        if (error) NSLog( @"Error writing image with metadata to Photo Library: %@", error );
        else NSLog( @"Wrote image with metadata to Photo Library %@", newURL.absoluteString);

    };
    
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:srcURL])
        [library writeVideoAtPathToSavedPhotosAlbum:srcURL completionBlock:videoWriteCompletionBlock];

}

- (CVPixelBufferRef)pixelBufferFromCGImage: (CGImageRef) image {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, width,
                                          height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata, width,
                                                 height, 8, 4*width, rgbColorSpace,
                                                 kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

- (void)loadAssetFromFile {
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoTempURL options:nil];
    NSString *tracksKey = @"tracks";
    
    NSLog(@"asset: %@", asset);
    
    // In the completion block, you create an instance of AVPlayerItem for the asset and set it as the player for the player view. As with creating the asset, simply creating the player item does not mean it’s ready to use. To determine when it’s ready to play, you can observe the item’s status property. You should configure this observing before associating the player item instance with the player itself.
    // You trigger the player item’s preparation to play when you associate it with the player.
    
    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:
     ^{
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSError *error;
                            AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
                            
                            if (status == AVKeyValueStatusLoaded) {
                                playerItem = [AVPlayerItem playerItemWithAsset:asset];
                                player = [AVPlayer playerWithPlayerItem:playerItem];
                                [self.previewView setPlayer:player];
                                
                                [player play];
                            }
                            else {
                                // You should deal with the error appropriately.
                                NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
                            }
                        });
     }];
    
}

@end
