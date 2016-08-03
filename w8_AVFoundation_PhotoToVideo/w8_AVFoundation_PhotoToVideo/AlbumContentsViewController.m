//
//  AppDelegate.h
//  w8_AVFoundation_PhotoToVideo
//
//  Created by Eunjoo Im on 2016. 8. 3..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "AlbumContentsViewController.h"
#import "PageViewControllerData.h"
#import "EJPhotoCell.h"
#import "EJVideoViewController.h"

@implementation AlbumContentsViewController

NSMutableArray *selectedPhotos;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonSelected)];

    self.navigationItem.rightBarButtonItem = btnDone;
    
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            [self.assets addObject:result];
        }
    };

    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    
    selectedPhotos = [NSMutableArray array];
    [self.collectionView setAllowsMultipleSelection:YES];
}

- (void) doneButtonSelected {
    if ([[self.collectionView indexPathsForSelectedItems] count] > 0) {
        
        [PageViewControllerData sharedInstance].photoAssets = self.assets;
        
        for (NSIndexPath *selectedCell in [self.collectionView indexPathsForSelectedItems]) {
            [selectedPhotos addObject:selectedCell];
        }
        
        EJVideoViewController *videoViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"videoPlayerViewController"];
        
        videoViewController.photoAssets = self.assets;
        videoViewController.targetIndexPaths = selectedPhotos;
        
        [self.navigationController pushViewController:videoViewController animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Pictures"
                                                        message:@"사진을 한 장 이상 선택해 주세요!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"photoCell";
    
    EJPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // load the asset for this cell
    ALAsset *asset = self.assets[indexPath.row];
    CGImageRef thumbnailImageRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];

    // apply the image to the cell
    cell.photoImageView.image = thumbnail;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    // Determine the selected items by using the indexPath
//    ALAsset *selectedPhoto = self.assets[indexPath.row];
//    // Add the selected item into the array
//    [selectedPhotos addObject:selectedPhoto];
    
    EJPhotoCell *cell = (EJPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.checkSelectionView.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ALAsset *deSelectedRecipe = self.assets[indexPath.row];
//    
//    [selectedPhotos removeObject:deSelectedRecipe];
    EJPhotoCell *cell = (EJPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.checkSelectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Segue support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showPhoto"]) {
        
        // hand off the assets of this album to our singleton data source
        [PageViewControllerData sharedInstance].photoAssets = self.assets;
        
        // start viewing the image at the appropriate cell index
//        MyPageViewController *pageViewController = [segue destinationViewController];
        NSIndexPath *selectedCell = [self.collectionView indexPathsForSelectedItems][0];
//        pageViewController.startingIndex = selectedCell.row;
    }
}

@end

