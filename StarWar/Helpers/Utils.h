//
//  Utils.h
//
//  Created by sidawang on 8/24/15.
//  Copyright (c) 2015 admax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Utils : NSObject
#pragma mark - coding related
-(void) dispatchAfter: (NSInteger)second withHandler:(void(^)()) handler;

+ (NSString*)base64encoder:(NSString*)str;
+(NSString *)base64decoder:(NSString *)str;
+(NSString*)urlEncode: (NSString*)str;
+(NSString*)urlDecode: (NSString*)str;
@end

