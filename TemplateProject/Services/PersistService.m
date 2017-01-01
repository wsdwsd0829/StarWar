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

//load team.json -> parse to Profiles and handler()
-(void)loadDataWithHandler: (DiskResultHandler) handler {
    [self loadDataFromBundleWithHandler:^(id responseObject, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [parser parse:responseObject withHandler:^(NSArray *objects, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     handler(objects, error);
                });
            }];
        });
    }];
}

-(void) loadDataFromBundleWithHandler: (DiskResultHandler) handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* path = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"json"];
        if(!path) {
            NSError* error = [NSError errorWithDomain:kErrorDomainDisk code: ErrorDiskNoFile userInfo:@{ kErrorDisplayUserInfoKey : @"no file at path"}];
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        }
        
        NSData* responseObject = [NSData dataWithContentsOfFile: path];
        if(!responseObject) {
            NSError* error = [NSError errorWithDomain:kErrorDomainDisk code: ErrorDiskLoadFail userInfo:@{ kErrorDisplayUserInfoKey : @"fail loading file at path"}];
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(responseObject, nil);
        });
    });
}

@end
