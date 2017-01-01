//
//  PersistentServiceProtocol.h
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ErrorDisk) {
    ErrorDiskNoFile = 1001, ErrorDiskLoadFail = 1002
};

typedef void(^DiskResultHandler)(id responseObject, NSError* error);

@protocol PersistServiceProtocol <NSObject>

//load async, and handler called on main
-(void)loadDataWithHandler: (DiskResultHandler) handler;

@end
