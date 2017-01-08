//
//  Created by Sida Wang on 12/26/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "CacheService.h"
#import "EventViewModel.h"

typedef void(^ViewModelItemsHandler) (NSArray* items, NSError* err);

@interface EventsViewModel : NSObject

@property (nonatomic) NSArray<EventViewModel*>* items;
@property (nonatomic, copy) void(^updateBlock)();

@property id<CacheServiceProtocol> cacheService;


-(void)loadImageForIndexPath:(NSIndexPath*)indexPath withHandler:(void(^)(UIImage* image))handler;
-(void)loadImageWithUrlString: urlString withHandler:(void(^)(UIImage* image))handler;
-(void) loadDataWithHandler: (ViewModelItemsHandler) handler;

//ui
-(NSString*) timeLabelForIndex: (NSInteger) index;
-(NSString*) locationForIndex: (NSInteger) index;
-(NSString*) titleForIndex:(NSInteger)index;
-(NSString*) descForIndex:(NSInteger)index;
-(NSString*) imageUrlForIndex: (NSInteger)index;

@end
