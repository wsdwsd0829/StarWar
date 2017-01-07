//
//  Constants.h
//
//  Created by Sida Wang on 12/26/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ImageListType) {
    ImageListTypeRecent, ImageListTypeInteresting
};

@interface Constants : NSObject

extern NSString* const kErrorDisplayUserInfoKey;

extern NSString* const kUserDefaultsImagePreference;
extern NSString* const kUserDefaultsImageListRecent;
extern NSString* const kUserDefaultsImageListInteresting;

extern NSString* const kNetworkOfflineToOnline;

extern NSString* const kErrorDomainDisk;
extern NSString* const kErrorDomainParse;
extern NSString* const kErrorDomainNetwork;

@end
