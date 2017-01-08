//
//  EventViewModel.m
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "EventViewModel.h"

@implementation EventViewModel

-(instancetype)initWithEvent:(Event*)event {
    self = [super init];
    if (self) {
        self.event = event;
    }
    return self;
}

//ui
-(NSString*) timeLabel {
    // create dateFormatter with UTC time format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    // change to a readable time format and change to local time zone
    //[dateFormatter setDateFormat:@"EEE, MMM d, yyyy - h:mm a"];//@"Thu, Jun 18, 2015 - 4:30 PM"
    [dateFormatter setDateFormat:@"MMM d, yyyy 'at' h:mm a"];//@"Thu, Jun 18, 2015 at 4:30 PM"

    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:self.event.date];
    //NSLog(@"%@", self.items[index].date);
    return timestamp;
    
}
-(NSString*) location {
    return [NSString stringWithFormat:@"%@, %@", self.event.locationLine1, self.event.locationLine2];
}
-(NSString*) title {
    return self.event.title;
}
-(NSString*) desc {
    return self.event.desc;
}
-(NSString*) imageUrl {
    return self.event.imageUrl;
}


@end
