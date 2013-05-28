//
//  PTNCoverView.h
//  PTNControls
//
//  Created by Peter Gusev on 8/15/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTNCoverViewDelegate;

/**
 * General cover view for fadding out elements on background while presenting views on top of it.
 */
@interface PTNCoverView : UIView

/**
 * @name Properties
 */
/**
 * Delegate of view
 */
@property (nonatomic, weak) IBOutlet id<PTNCoverViewDelegate> delegate;

@end

/**
 * Protocol for PTNCoverView
 */
@protocol PTNCoverViewDelegate <NSObject>

@optional
/**
 * Called upon tapping cover view
 */
-(void)coverViewWasTapped:(PTNCoverView*)coverView;

@end