//
//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 [{
 "id": 1,
 "description": "Rebel Forces spotted on Hoth. Quell their rebellion for the Empire.",
 "title": "Stop Rebel Forces",
 "timestamp": "2015-06-18T17:02:02.614Z",
 "image": "https://raw.githubusercontent.com/phunware/services-interview-resources/master/images/Battle_of_Hoth.jpg",
 "date": "2015-06-18T23:30:00.000Z",
 "phone": "1 (800) 545-5334",
 "locationline1": "Hoth",
 "locationline2": "Anoat System"
 },...]
 */
@interface Event : NSObject

@property (nonatomic, copy, readonly) NSString* identifier;
@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, copy, readonly) NSString* desc;
@property (nonatomic, copy) NSDate* timestamp;

//optional
@property (nonatomic, copy) NSString* imageUrl;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSDate* date; //in gmt, should in user timezone

@property (nonatomic, copy) NSString* locationLine1;
@property (nonatomic, copy) NSString* locationLine2;

-(instancetype) initWithIdentifier: (NSString*) identifier withTitle: (NSString*) title withTimestamp:(NSDate*) timestamp withDesc:(NSString*) desc;
@end
