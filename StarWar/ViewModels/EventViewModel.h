//
//  EventViewModel.h
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
@interface EventViewModel : NSObject

@property (nonatomic) Event* event;

-(instancetype)initWithEvent:(Event*)event;

//ui
-(NSString*) timeLabel;
-(NSString*) location;
-(NSString*) title;
-(NSString*) desc;
-(NSString*) imageUrl;
-(NSString*) phone;

@end
