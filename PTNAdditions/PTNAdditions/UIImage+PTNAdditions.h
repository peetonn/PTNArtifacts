//
//  UIImage+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 9/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Contains extensions for UIImage like cropping/resizing/complex combining images
 */
@interface UIImage (PTNAdditions)
/**
 * Generates new image with img2 as a base background and img1 on top of it. Img1 get scaled with scale factor and center of img1 is placed in (kx*w,ky*h) point, where w and h - width and height of img2 respectively.
 */
+(UIImage*)putImage:(UIImage*)img1 onImage:(UIImage*)img2 withScale:(CGFloat)scale andCenterRatioX:(CGFloat)kx andY:(CGFloat)ky;

/**
 * Creates new image resized to new size
 */
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 * Createds new images cropped to rectangle
 */
+(UIImage*)imageWithImage:(UIImage *)image croppedToRect:(CGRect)rect;

/**
 * Creates new image by aspect resise of provided image to provided size and crops from upper and down sides 
 */
+(UIImage*)imageWithImage:(UIImage *)image aspectScaledAndCropped:(CGRect)rect;

@end
