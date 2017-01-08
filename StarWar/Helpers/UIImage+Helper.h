//
//  UIImage+Size.h
//  StarWar
//
//  Created by Sida Wang on 1/7/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
