//
//  TestCell.m
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes* attr = [[super preferredLayoutAttributesFittingAttributes:layoutAttributes] copy];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentWidth.constant = 400;
    CGRect oldFrame = attr.frame;
    oldFrame.size.width = self.contentWidth.constant;
    CGSize sizeFits = [self sizeThatFits:oldFrame.size];
    //self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    //NSLog(@"%@", DeviceVersionNames[[SDVersion deviceVersion]] );
    //BOOL isIphone = [DeviceVersionNames[[SDVersion deviceVersion]] containsString:@"iPhone"];
    //self.width.constant = screenWidth; //isIphone ? screenWidth : screenWidth/2;
    
    CGSize size = [self systemLayoutSizeFittingSize:oldFrame.size];
    CGRect newFrame = attr.frame;
    newFrame.size.height = size.height;
    attr.frame = newFrame;
    
    self.imageHeight.constant = size.height;
    self.imageWidth.constant = self.contentWidth.constant;
    return attr;
}

@end
