//
//  GameViewController.m
//  w11_MultipeerConnectivity
//
//  Created by Eunjoo Im on 2016. 8. 24..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "GameViewController.h"
#import "SessionContainer.h"
#import "Transcript.h"

@interface GameViewController () <MCBrowserViewControllerDelegate, SessionContainerDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *gameNumberLabel;

@end

@implementation GameViewController

int gameNumber;

- (void)viewDidLoad {
    [super viewDidLoad];

    _sessionContainer.delegate = self;
    NSLog(@"------%@----", _sessionContainer);
    NSLog(@"service: %@, name: %@", _serviceType, _displayName);
    self.title = _serviceType;
    gameNumber = 0;
    _gameNumberLabel.text = [NSString stringWithFormat:@"%d", gameNumber];
}

- (IBAction)plusButtonTapped:(id)sender {
    [self.sessionContainer sendMessage:@"+"];
}

- (IBAction)minusButtonTapped:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self minusNumber];
    });
}

- (void)minusNumber {
    gameNumber--;
    _gameNumberLabel.text = [NSString stringWithFormat:@"%d", gameNumber];
}

- (IBAction)browseForPeers:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:_serviceType session:self.sessionContainer.session];
    
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    
    [self presentViewController:browserViewController animated:YES completion:nil];
}

#pragma mark - MCBrowserViewControllerDelegate methods

- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    return YES;
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SessionContainerDelegate

- (void)receivedTranscript:(Transcript *)transcript {
    if ([transcript.message isEqualToString: @"+"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertTranscript:transcript];
        });
    }
}

- (void)insertTranscript:(Transcript *)transcript {
    gameNumber++;
    _gameNumberLabel.text = [NSString stringWithFormat:@"%d", gameNumber];
}

- (void)updateTranscript:(Transcript *)transcript {
}

@end
