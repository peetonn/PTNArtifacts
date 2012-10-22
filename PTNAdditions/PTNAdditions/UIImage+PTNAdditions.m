//
//  UIImage+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 9/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "UIImage+PTNAdditions.h"

@implementation UIImage (PTNAdditions)

+(UIImage*)putImage:(UIImage*)img1 onImage:(UIImage*)img2 withScale:(CGFloat)scale andCenterRatioX:(CGFloat)kx andY:(CGFloat)ky
{

    CGSize size = CGSizeMake(img2.size.width, img2.size.height);    
    
    UIGraphicsBeginImageContextWithOptions(size, NO, img2.scale);
    
    [img2 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CGFloat w = scale*img1.size.width, h = scale*img1.size.height;
    CGFloat x = size.width*kx - .5*w, y = size.height*ky - .5*h;
    
    [img1 drawInRect:CGRectMake(x, y, w, h)];
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return res;
}

@end
