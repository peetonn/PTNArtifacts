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

+(UIImage*)imageWithImage:(UIImage*)image rotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
//    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
//    CGAffineTransform t = CGAffineTransformMakeRotation(M_PI*degrees/180.);
//    rotatedViewBox.transform = t;
//    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    CGFloat scale = image.scale;//[[UIScreen mainScreen] scale];
    CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, image.scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, imageSize.width/2, imageSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, M_PI*degrees/180.);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-imageSize.width / 2, -imageSize.height / 2, imageSize.width, imageSize.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
