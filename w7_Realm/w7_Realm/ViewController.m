//
//  ViewController.m
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonDataManager.h"
#import "PersonAddViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *personTableView;

@end

@implementation ViewController

NSMutableArray *dataArray;
RLMNotificationToken *token;
PersonDataManager *dataManager;

- (IBAction)addButtonTapped:(id)sender {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dataArray = [dataManager getAllData];
}
                 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _personTableView.dataSource = (id)self;
    _personTableView.delegate = (id)self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(dataChanged:) name:@"dataChanged" object:nil];
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    token = [realm addNotificationBlock:^(NSString *notification, RLMRealm * realm) {
//        NSLog(@"data changed");
//        dataArray = [dataManager getAllData];
//        [_personTableView reloadData];
//    }];
    
    dataManager = [PersonDataManager sharedInstance];
}

- (void)dataChanged:(NSNotification*)notification {
    dataArray = [dataManager getAllData];
    [_personTableView reloadData];
}

- (NSMutableArray *)personDataArray {
    return dataArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"rows: %d", [dataArray count]);
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"personCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Person *person = [dataArray objectAtIndex:indexPath.row];
    NSLog(@"%d: %@ now: %@", indexPath.row, person, person.name);
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", person.age];

    return cell;
}

#pragma mark - tableViewDetail
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected: %d", indexPath.row);
    
    Person *targetData = [dataArray objectAtIndex:indexPath.row];
    PersonAddViewController *addViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addViewController"];
    
    addViewController.originalPerson = targetData;
    
    [self presentViewController:addViewController animated:NO completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_personTableView beginUpdates];
    
    Person *targetData = [dataArray objectAtIndex:indexPath.row];

    [dataManager deletePerson:targetData.id];
    [dataArray removeObjectAtIndex:indexPath.row];
    
    [_personTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    [_personTableView endUpdates];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [token stop];
}


@end
