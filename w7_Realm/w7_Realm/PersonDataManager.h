//
//  PersonDataManager.h
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "person.h"

@interface PersonDataManager : NSObject

+ (PersonDataManager *)sharedInstance;


- (int)getIdManager;
- (Person *)getPerson:(int)id;
- (void)addOrUpdatePerson:(Person *)person;
- (void)deletePerson:(int)id;
- (NSMutableArray *)getAllData;

@end
