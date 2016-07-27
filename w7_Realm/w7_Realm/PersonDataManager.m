//
//  PersonDataManager.m
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "PersonDataManager.h"

@implementation PersonDataManager

RLMRealm *realm;
int idManager;

+ (PersonDataManager *)sharedInstance {
    static dispatch_once_t pred;
    static PersonDataManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[PersonDataManager alloc] init];
        realm = [RLMRealm defaultRealm];
        idManager = [[[Person allObjects] maxOfProperty:@"id"] intValue] + 1;
    });
    
    return shared;
}

- (int)getIdManager {
    NSLog(@"idManager: %d", idManager);
    return idManager++;
}

- (Person *)getPerson:(int)id {
    return [Person objectInRealm:realm forPrimaryKey:@(id)];
}

- (void)addOrUpdatePerson:(Person *)person {
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:person];
    [realm commitWriteTransaction];
}

- (void)deletePerson:(int)id {
    [realm beginWriteTransaction];
    Person *person = [self getPerson:id];
    [realm deleteObject:person];
    [realm commitWriteTransaction];
}

- (NSMutableArray *)getAllData {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    RLMResults *allData = [Person allObjects];

    for (Person *person in allData) {
        [resultArray addObject:person];
    }
    
    return resultArray;
}

@end
