//
//  Created by Sida Wang on 12/26/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

//Services
#import "MessageManager.h"
#import "PereferenceService.h"
#import "NetworkService.h"

//ViewModels
#import "EventsViewModel.h"


@interface EventsViewModel() {
    //private backing stores
    //for ui
    NSMutableArray<Event*>* _items;
    id<NetworkServiceProtocol> networkService;
    
    id<MessageManagerProtocol> messageManager;
}

@end

@implementation EventsViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        networkService = [[NetworkService alloc] init];
        messageManager = [[MessageManager alloc] init];
       // [[NSException exceptionWithName:@"Wrong usage" reason:@"Must provide a type of image to load using initWithType:" userInfo:nil] raise];
    }
    return self;
}

-(void) loadDataWithHandler: (ViewModelItemsHandler) handler {
    [networkService loadItems:^(NSArray *items, NSError *error) {
        if(error) {
            [self p_handleError:error];
        } else {
            self.items = items;
            handler(items, nil);
        }
    }];
}

-(Event*)previousItemFor:(Event *)item {
    NSInteger index = [self.items indexOfObject: item];
    if(index == 0) {
        return nil;
    }
    return self.items[index - 1];
}

-(Event*)nextItemFor:(Event *)item {
    NSInteger index = [self.items indexOfObject: item];
    if(index == self.items.count-1) {
        return nil;
    }
   return self.items[index + 1];
}

-(void)loadImageForIndexPath:(NSIndexPath*)indexPath withHandler:(void(^)(UIImage* image))handler {
    NSString* urlString = self.items[indexPath.row].imageUrl;
    UIImage* img = [self.cacheService imageForName:urlString];
    if(!img) {
        [networkService loadImageWithUrlString: urlString withHandler:^(NSData *data, NSError* error) {
            if(error) {
                NSLog(@"loadImageForIndexPath error: %@", error);
                [self p_handleError:error];
                return;
            }
            UIImage* newImage = [UIImage imageWithData:data];
            [self.cacheService setImage: newImage forName:urlString];
            handler(newImage);
        }];
    } else {
        handler(img);
    }
}

-(void)loadImageWithUrlString: urlString withHandler:(void(^)(UIImage* image))handler  {
    UIImage* img = [self.cacheService imageForName:urlString];
    if(img) {
        handler(img);
        return;
    }
    [networkService loadImageWithUrlString: urlString withHandler:^(NSData *data, NSError* error) {
        if(error) {
            NSLog(@"loadImageWithUrlString error: %@", error);
            [self p_handleError:error];
            return;
        }
        if(data) {
            UIImage* newImage = [UIImage imageWithData:data];
            if(newImage) {
                handler(newImage);
                [self.cacheService setImage: newImage forName:urlString];
            }
        }
    }];
}

-(void) p_handleError:(NSError*)error {
    [messageManager showError:error];
}

//ui
-(NSString*) timeLabelForIndex: (NSInteger) index {
    //NSLog(@"%@", self.items[index].date);
    return [self.items[index].date description];
    
}
-(NSString*) locationForIndex: (NSInteger) index {
    return [NSString stringWithFormat:@"%@, %@", self.items[index].locationLine1, self.items[index].locationLine2];
}
-(NSString*) titleForIndex:(NSInteger)index {
    return self.items[index].title;
}
-(NSString*) descForIndex:(NSInteger)index {
    return self.items[index].desc;
}
-(NSString*) imageUrlForIndex: (NSInteger)index {
    return self.items[index].imageUrl;
}

@end
