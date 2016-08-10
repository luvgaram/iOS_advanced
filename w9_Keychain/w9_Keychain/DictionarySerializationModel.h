//
//  DictionarySerializationModel.h
//  w9_Keychain
//
//  Created by Eunjoo Im on 2016. 8. 10..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DictionarySerializationModel : NSObject

- (void)addStudentWithNumber:(NSString *)number andName:(NSString *)name;
- (void)deleteStudentWithNumber:(NSString *)number;
- (NSData *)serializeStudentDictionary;
- (NSDictionary *)deserializingXML:(NSData *)data;
- (void)writeToKeychain;
- (void)readFromKeychain;

@end
