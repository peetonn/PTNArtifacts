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

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)imageWithImage:(UIImage *)image croppedToRect:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x*image.scale,
                          rect.origin.y*image.scale,
                          rect.size.width*image.scale,
                          rect.size.height*image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}

+(UIImage*)imageWithImage:(UIImage *)image aspectScaledAndCropped:(CGRect)rect
{
    CGFloat scaleX = rect.size.width/image.size.width;
    CGFloat scaleY = rect.size.height/image.size.height;
    CGFloat scaleK = (scaleX > scaleY)?scaleX:scaleY;
    CGSize resizeSize = CGSizeMake(image.size.width*scaleK, image.size.height*scaleK);
    
    return [UIImage imageWithImage:[UIImage imageWithImage:image scaledToSize:resizeSize] croppedToRect:rect];
}
@end
