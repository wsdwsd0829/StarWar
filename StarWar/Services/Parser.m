//
//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "Parser.h"
#import "Event.h"

@implementation Parser

-(void)parse:(id)responseObject withHandler:(void (^)(NSArray *, NSError *))handler {
    [self parseToItemsWith:responseObject withHandler:handler];
}

-(void)parseToItemsWith: (id) responseObject withHandler: (void(^)(NSArray* items, NSError* error)) handler {
    NSMutableArray* results = [NSMutableArray new];
    NSError* error;
    id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
    if(error != nil) {
        NSError* err = [NSError errorWithDomain:kErrorDomainParse code:ErrorParseFailed userInfo: @{kErrorDisplayUserInfoKey: @"Fail to parse json to array"}];
                    handler(nil, err);
        return;
    }
    if([response isKindOfClass: [NSArray class]]) {
        NSArray* objs = (NSArray*) response;

            //2015-06-18T23:30:00.000Z
            //NSString *dateString =  @"2014-10-07T07:29:55.850Z";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            [dateFormatter setTimeZone:gmt];
        
            for(id obj in objs) {
                @autoreleasepool {
                    if([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* objDict = (NSDictionary*) obj;
                        NSString* title = objDict[@"title"];
                        NSString* identifier = objDict[@"id"];
                        NSString* timestampStr = objDict[@"timestamp"];
                        NSDate* timestamp = [dateFormatter dateFromString:timestampStr];
                        NSString* desc = objDict[@"description"];
                        if(title && identifier && timestamp && desc) {
                            
                            Event* newItem = [[Event alloc] initWithIdentifier: identifier withTitle: title withTimestamp: timestamp withDesc: desc];
                            
                            newItem.imageUrl = [objDict objectForKey: @"image"];
                            newItem.phone = [objDict objectForKey: @"phone"];
                            newItem.date = [dateFormatter dateFromString: [objDict objectForKey: @"date"]];
                            newItem.locationLine1 = [objDict objectForKey: @"locationline1"];
                            newItem.locationLine2 = [objDict objectForKey: @"locationline2"];
                            [results addObject:newItem];
                        }
                    }
                }
            }
    }
    
    if(results.count > 0) {
        handler(results, nil);
    } else {
        NSError* err = [NSError errorWithDomain:kErrorDomainParse code:ErrorParseFailed userInfo: @{kErrorDisplayUserInfoKey: @"No events loaded"}];
        handler(nil, err);
    }
}
@end
