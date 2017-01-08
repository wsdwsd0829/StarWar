//
//  PersistentService.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "PersistService.h"
#import "Parser.h"

@implementation PersistService {
    id<ParserProtocol> parser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        parser = [[Parser alloc] init];
    }
    return self;
}


-(void) loadItemsWithFileName:(NSString*) name withHandler: (DiskResultHandler)handler  {
    //applications Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:name];
    NSData* responseObject = [NSData dataWithContentsOfFile:filePath];
    [parser parse:responseObject withHandler: ^(NSArray* items, NSError* error) {
        handler(items, error);
    }];
    
}


-(BOOL) writeDataToDisk:(NSData*)data withName:(NSString*) name{
    //applications Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:name];
    return [data writeToFile:filePath atomically:YES];
}

@end
