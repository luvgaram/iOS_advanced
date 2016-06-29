//
//  SecondViewController.m
//  w3_XIBProblem
//
//  Created by Eunjoo Im on 2016. 6. 29..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "CalendarViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstCelltapped:)];
    [_firstCell addGestureRecognizer:tap];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondCelltapped:)];
    [_secondCell addGestureRecognizer:tap];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdCelltapped:)];
    [_thirdCell addGestureRecognizer:tap];
}

- (void)firstCelltapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%@", @"first cell tapped");
    ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    [self presentViewController:thirdVC animated:YES completion:nil];
}

- (void)secondCelltapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%@", @"second cell tapped");
 
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = (id)self;
        [self presentViewController: controller animated: YES completion: nil];
    }
}

- (void)thirdCelltapped:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%@", @"third cell tapped");
    CalendarViewController *calVC = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
    [self presentViewController:calVC animated:YES completion:nil];
}


#pragma mark - Image Picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated: YES completion: nil];
    _secondImageView.image = [info valueForKey: UIImagePickerControllerOriginalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated: YES completion: nil];
}
@end
