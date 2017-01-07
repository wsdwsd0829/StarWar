//
//  EventCell.m
//  StarWar
//
//  Created by Sida Wang on 1/6/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "EventCell.h"
@interface EventCell()
@end
@implementation EventCell
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       // self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        //self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}


-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes* attr = [[super preferredLayoutAttributesFittingAttributes:layoutAttributes] copy];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.width.constant = 400;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
;
    CGRect oldFrame = attr.frame;
    oldFrame.size.width = self.width.constant;
    //self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
   //NSLog(@"%@", DeviceVersionNames[[SDVersion deviceVersion]] );
    //BOOL isIphone = [DeviceVersionNames[[SDVersion deviceVersion]] containsString:@"iPhone"];
    //self.width.constant = screenWidth; //isIphone ? screenWidth : screenWidth/2;
    
    CGSize size = [self systemLayoutSizeFittingSize:oldFrame.size];
    CGRect newFrame = attr.frame;
    newFrame.size.height = size.height;
    attr.frame = newFrame;
    
    self.imageHeight.constant = size.height;
    self.imageWidth.constant = self.width.constant;
    return attr;
}


@end
