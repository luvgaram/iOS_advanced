//
//  DictionarySerializationModel.m
//  w9_Keychain
//
//  Created by Eunjoo Im on 2016. 8. 10..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "DictionarySerializationModel.h"
#import "KeychainItemWrapper.h"

@implementation DictionarySerializationModel

NSMutableDictionary *studentDictionary;

- (id)init {
    self = [super init];
    
    if (self) {
        if (studentDictionary == nil)
            studentDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)addStudentWithNumber:(NSString *)number andName:(NSString *)name {
    [studentDictionary setObject:name forKey:number];
    NSLog(@"added: %@", studentDictionary);
}

- (void)deleteStudentWithNumber:(NSString *)number {
    [studentDictionary removeObjectForKey:number];
    NSLog(@"deleted: %@", studentDictionary);
}

- (NSData *)serializeStudentDictionary {
    NSError *error;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:studentDictionary format:(NSPropertyListFormat)kCFPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if (data == nil) NSLog(@"error serializing to xml: %@", error);
    return data;
}

//- (void)prepareDic {
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
//}
//
//-(NSMutableDictionary*) prepareDict {
//    NSString *service = @"aa";
//
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
//    
//    NSData *encodedKey = [self serializeStudentDictionary];
//    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrGeneric];
//    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrAccount];
//    [dict setObject:service forKey:(__bridge id)kSecAttrService];
//    [dict setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
//    
//    return  dict;
//}
//
//- (BOOL)insert:(NSData *)data {
//    NSMutableDictionary * dict =[self prepareDict];
//    [dict setObject:data forKey:(__bridge id)kSecValueData];
//    
//    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
//    if(errSecSuccess != status) {
//        NSLog(@"Unable add item with error:%ld", status);
//    }
//    return (errSecSuccess == status);
//}
//
//- (NSData*) find{
//    NSMutableDictionary *dict = [self prepareDict];
//    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
//    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
//    CFTypeRef result = NULL;
//    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict,&result);
//    
//    if( status != errSecSuccess) {
//        NSLog(@"Unable to fetch item with error:%ld", status);
//        return nil;
//    }
//    
//    return (__bridge NSData *)result;
//}
//
//-(BOOL) update:(NSData*) data {
//    NSMutableDictionary * dictKey =[self prepareDict];
//    
//    NSMutableDictionary * dictUpdate =[[NSMutableDictionary alloc] init];
//    [dictUpdate setObject:data forKey:(__bridge id)kSecValueData];
//    
//    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)dictKey, (__bridge CFDictionaryRef)dictUpdate);
//    if(errSecSuccess != status) {
//        NSLog(@"Unable add update error:%ld",status);
//    }
//    return (errSecSuccess == status);
//    
//    return YES;
//    
//}
//- (BOOL)remove: (NSString*)key {
//    NSMutableDictionary *dict = [self prepareDict];
//    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);
//    if( status != errSecSuccess) {
//        NSLog(@"Unable to remove item with error:%ld", status);
//        return NO;
//    }
//    return  YES;
//}
//- (void)writeToKeychain {
//    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"arbitraryId" accessGroup:nil];
//    [keychain setObject:[self serializeStudentDictionary] forKey:(id)kSecAttrGeneric];
//}
//
//- (void)readFromKeychain {
//    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"arbitraryId" accessGroup:nil];
//    NSString *error;
//
//    NSData *dictionaryRep = [keychain objectForKey:kSecClass];
//    NSLog(@"dictionaryRep: %@", dictionaryRep);
//    NSDictionary *dictionary = [self deserializingXML:dictionaryRep];
//    NSLog(@"dicionary: %@", dictionary);
//}
- (void)writeToKeychain {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"arbitraryId" accessGroup:nil];
    
    NSString *newString = [[NSString alloc] initWithData:[self serializeStudentDictionary] encoding:NSUTF8StringEncoding];
    [keychain setObject:newString forKey:kSecAttrAccount];

}

- (void)readFromKeychain {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"arbitraryId" accessGroup:nil];
    NSString *error;

    NSString *readString = [keychain objectForKey:kSecAttrAccount];
    NSData* data = [readString dataUsingEncoding:NSUTF8StringEncoding];
    studentDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:nil error:&error];
    
    if (readString.length > 0) {
        NSData* data = [readString dataUsingEncoding:NSUTF8StringEncoding];
        studentDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:nil error:&error];
        NSLog(@"read: %@", studentDictionary);
    }
    
    if (error) NSLog(@"%@", error);
}

@end
