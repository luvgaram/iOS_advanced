//
//  Person.m
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSString *)primaryKey {
    return @"id";
}

+ (NSArray *)requiredProperties {
    return @[@"id", @"name", @"age"];
}

@end
