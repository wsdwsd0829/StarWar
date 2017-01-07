//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype) initWithIdentifier: (NSString*) identifier withTitle: (NSString*) title withTimestamp:(NSDate*) timestamp withDesc:(NSString*) desc{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _title = title;
        _timestamp = timestamp;
        _desc = desc;
    }
    return self;
}

@end
