//
//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "Parser.h"
#import "Photo.h"

@implementation Parser

-(void)parse:(id)responseObject withHandler:(void (^)(NSArray *, NSError *))handler {
    [self parseToItemsWith:responseObject withHandler:handler];
}

-(void)parseToItemsWith: (id) responseObject withHandler: (void(^)(NSArray* items, NSError* error)) handler {
    NSMutableArray* results = [NSMutableArray new];
    if([responseObject isKindOfClass: [NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*) responseObject;
        int count = 0;
        if([dict objectForKey:@"query"] && [dict[@"query"] objectForKey:@"count"]) {
            count = [dict[@"query"][@"count"] intValue];
        } else {
            NSError* err = [NSError errorWithDomain:kErrorDomainParse code:ErrorParseFailed userInfo: @{kErrorDisplayUserInfoKey: @"No more images"}];
            handler(nil, err);
            return;
        }
        if(count > 0 && [dict[@"query"] objectForKey: @"results"] && [dict[@"query"][@"results"] objectForKey:@"photo"]) {
            NSArray* objs = dict[@"query"][@"results"][@"photo"];
            for(id obj in objs) {
                @autoreleasepool {
                    if([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* objDict = (NSDictionary*) obj;
                        NSString* farm = objDict[@"farm"];
                        NSString* identifier = objDict[@"id"];
                        NSString* secret = objDict[@"secret"];
                        NSString* server = objDict[@"server"];
                        if(farm && identifier && secret && server) {
                            NSString* orginalUrlStr = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, identifier, secret];
                            NSString* thumbnailUrlStr = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_t_d.jpg", farm, server, identifier, secret];
                            NSString* identity = [NSString stringWithFormat:@"%@_%@_%@_%@", farm, identifier, secret, server];
                            
                            Photo* newItem = [[Photo alloc] initWithOriginalImageUrlString:orginalUrlStr withThumbnailImageUrlString:thumbnailUrlStr withIdentifier:identity];
                            
                            newItem.title = [objDict objectForKey: @"title"];
                            [results addObject:newItem];
                        }
                    }
                }
            }
        }
    }
    
    if(results.count > 0) {
        handler(results, nil);
    } else {
        NSError* err = [NSError errorWithDomain:kErrorDomainParse code:ErrorParseFailed userInfo: @{kErrorDisplayUserInfoKey: @"Fail to parse profiles"}];
        handler(nil, err);
    }
}
@end
