//
//  Created by Sida Wang on 12/26/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ErrorNetwork) {
    ErrorNetworkFail = 1001
};

typedef void(^NetworkResultHandler)(NSArray* images, NSError* error);

@protocol NetworkServiceProtocol <NSObject>

-(void)loadImageWithUrlString: (NSString*) urlString withHandler:(void(^)(NSData* data, NSError* error))handler;

-(void)loadPhotosWithType: (ImageListType)type withHandler:(NetworkResultHandler) handler;

@end
