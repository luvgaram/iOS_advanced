//
//  EJDataManager.m
//  w10_GCD
//
//  Created by Eunjoo Im on 2016. 8. 17..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDataManager.h"

@implementation EJDataManager

- (NSArray *)getDataFromURL {
    NSURL *url = [self urlForString:@"http://125.209.194.123/doodle.php"];
    NSData *newData = [self getJsonFromURL:url];
    return [self serializingJSON:newData];
}

- (NSArray *)serializingJSON:(NSData *)data {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *imageURL;
    for (NSDictionary *item in rawArray) {
        imageURL = [item objectForKey:@"image"];
        [resultArray addObject:[self urlForString:imageURL]];
    }
    
    return resultArray;
}

- (NSData *)getJsonFromURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}

- (NSURL *)urlForString:(NSString *)urlString {
    return [[NSURL alloc] initWithString:urlString];
}

@end
