//
//  EventView.m
//  StarWar
//
//  Created by Sida Wang on 1/6/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "EventView.h"
@interface EventView()

@property (strong, nonatomic) IBOutlet UIView *view;

@end
@implementation EventView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    }
    return self;
}


@end
