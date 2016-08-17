//
//  ViewController.m
//  w10_GCD
//
//  Created by Eunjoo Im on 2016. 8. 17..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "EJDataManager.h"
#import "EJCollectionViewCell.h"

@interface ViewController ()  <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *logoCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *logoFlowLayout;

@end

@implementation ViewController

NSArray *dataArray;
bool willScaleUp = false;

# pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _logoCollectionView.dataSource = self;
    _logoCollectionView.delegate = self;
    
    EJDataManager *dataManager = [[EJDataManager alloc] init];
    
    dataArray = [dataManager getDataFromURL];
//    dataArray = [NSMutableArray array];
//    
//    for (int i = 0; i < 100; i++) {
//        [dataArray addObject:@"test"];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"dataArray: %lu", (unsigned long)[dataArray count]);
    return [dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"logoImageCell";
    
    EJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.logoImageView.image = [UIImage imageNamed:@"placeholder.png"];
    
    NSURL *url = [dataArray objectAtIndex:indexPath.row];
    
    // GCD + GCD
//    dispatch_queue_t queue =
//    dispatch_queue_create("org.nhnnext.GCD", NULL); // serial queue
////    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0); // concurrent queue
//    
//    dispatch_sync(queue, ^{
//        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//    
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.logoImageView.image = img;
//        });
//    });
    
    // NSURLSession(async) + GCD
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.logoImageView.image = image;
                });
            }
            }
    }];
    [task resume];
    
    return cell;
    
    // semaphore 사용: 단 세마포 사용보다 시리얼 큐를 여러개 만들어서 관리하는 것이 나을 수 있음
    //    dispatch_semaphore_t semaphor = dispatch_semaphore_create(1);
    //    dispatch_semaphore_signal(semaphore);
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize original = CGSizeMake(128, 50);
    CGSize scaleUp = CGSizeMake(128 * 2, 50 * 2);

    if (willScaleUp) {
        [_logoFlowLayout setItemSize:original];
    } else {
        [_logoFlowLayout setItemSize:scaleUp];
    }
    
    willScaleUp = !willScaleUp;

//    EJCollectionViewCell *updateCell = (id)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    UIImage *image = updateCell.logoImageView.image;
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    
//    [self.view addSubview:imageView];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//    CGRect frame = updateCell.logoImageView.frame;
//    imageView.frame = frame;
//    
//    [UIView animateWithDuration:1 animations:^{
////        imageView.frame = newFrame;
////        updateCell.frame = newFrame;
////        [collectionView.collectionViewLayout invalidateLayout];
//    } completion:^(BOOL finished) {
////        updateCell.frame = originalFrame;
////        [collectionView.collectionViewLayout invalidateLayout];
//    }];
}


@end
