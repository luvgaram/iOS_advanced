//
//  main.m
//  persistence
//
//  Created by Eunjoo Im on 2016. 6. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *glossary = @{
                                   @"추상클래스" : @"특정 클래스를 상속받아 만들 수 있는 클래스",
                                   @"adopt" : @"프로토콜에 정의된 모든 메서드를 구현하는 것",
                                   @"archiving" : @"객체를 재사용하기 위해 저장하는 것"
                                   };
//        if ([glossary writeToFile:@"glossary" atomically:YES] == NO) {
//            NSLog(@"Save to file failed");
//        }
        [NSKeyedArchiver archiveRootObject:glossary toFile:@"glossary.archive"];
        glossary = [NSKeyedUnarchiver unarchiveObjectWithFile:@"glossary.archive"];
        NSLog(@"%@", glossary);
        
    }
    return 0;
}
