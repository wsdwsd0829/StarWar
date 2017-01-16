//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//
#import "ApiClientProtocol.h"
#import "ParserProtocol.h"
#import "Reachability.h"
#import "NetworkService.h"
#import "PersistService.h"
#import "ApiClient.h"
#import "Parser.h"
//https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20flickr.photos.interestingness%20where%20api_key%3D%27d5c7df3552b89d13fe311eb42715b510%27&diagnostics=true&format=json
//https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20flickr.photos.recent%20where%20api_key%3D%27d5c7df3552b89d13fe311eb42715b510%27&diagnostics=true&format=json
NSString* const apiKey = @"d33ef16f7b9d67141aa1f5b164b59101";//@"d5c7df3552b89d13fe311eb42715b510";

@interface NetworkService () {
    id<ApiClientProtocol> apiClient;
    id<ParserProtocol> parser;
    Reachability* reachability;
    id<PersistServiceProtocol> persist;
    NSUInteger pageNum;
    NSUInteger pageCount;
}

@end
@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        apiClient = [ApiClient defaultClient];
        parser = [[Parser alloc] init]; //? can this be singeton, can I just use static method to parse data
        
        //setup reachability
        reachability = [Reachability reachabilityForInternetConnection];
        persist = [PersistService new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
        [reachability startNotifier];
        
        pageNum = 0;
        pageCount = 20;
    }
    return self;
}

-(void)loadImageWithUrlString: (NSString*) urlString withHandler:(void(^)(NSData* data, NSError* error))handler{
    //GCD or Operation
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(imageData);
        });
    });
     */
    [apiClient fetchWithUrlString:urlString withHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        handler(responseObject, error);
    }];
}

-(void) loadItems: (NetworkResultHandler)handler {
   // NSLog(@"Recent Images Page Num: %lu", (unsigned long)pageNum);
    [self p_fetchWithParams:nil withHandler:handler];
}


//https://raw.githubusercontent.com/phunware/dev-interview-homework/master/feed.json
//private method that use apiClient to fetch Data and use parser to get object (can parse async)
-(void) p_fetchWithParams: (NSDictionary*) params withHandler:(NetworkResultHandler) handler {
    pageNum += 1; //how to deal wich if previous page load fails
    [apiClient fetchWithParams:params withApi: @"phunware/dev-interview-homework/master/feed.json" withHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error && ((NSHTTPURLResponse*)response).statusCode == 200) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [persist writeDataToDisk: responseObject withName:@"events.json"];
                //Parse result in background thread
                [parser parse:responseObject withHandler: ^(NSArray* items, NSError* error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(items, error);
                    });
                    //!!!cannot increase page num here cause, same page may load multiple times
                }];
            });
           
        } else {
            // if status Code 401, need re-auth;
            handler(nil, error);
        }
    }];
}

//Mark: Reachability Protocol
-(void)networkChanged:(NSNotification*) notification {
    Reachability* reach = notification.object;
    if([reach currentReachabilityStatus] == ReachableViaWiFi || [reach currentReachabilityStatus] == ReachableViaWWAN) {
        NSString* isFromNotReachable = [[NSUserDefaults standardUserDefaults] stringForKey:@"kNotReachable"];
        if([isFromNotReachable isEqualToString:@"YES"]) {
            [self networkChangedFromOfflineToOnline:notification];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kNotReachable"];
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kNotReachable"];
    }
}

-(void)networkChangedFromOfflineToOnline:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkOfflineToOnline object: notification.object];
}

-(void)dealloc {
    [reachability stopNotifier];
}
@end
