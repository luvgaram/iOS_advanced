//
//  Person.h
//  w7_Realm
//
//  Created by Eunjoo Im on 2016. 7. 27..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Realm/Realm.h>

@interface Person : RLMObject

// v0
//@property NSInteger id;
//@property NSString *name;
//@property NSInteger age;

// v1
@property NSInteger id;
@property NSString *name;
@property NSInteger age;
@property BOOL isMale; //new object

@end

RLM_ARRAY_TYPE(Person)
