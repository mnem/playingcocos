//
//  AppDelegate.h
//  playingcocos
//
//  Created by David Wagner on 19/04/2011.
//  Copyright Noise & Heat 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
