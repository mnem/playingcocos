//
//  FramerateIndicatorEntity.h
//  playingcocos
//
//  Created by David Wagner on 26/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface FramerateIndicatorEntity : CCNode {
	CCProgressTimer* framerate;
	CCSprite* framerateMarks;
}

@property(assign) CCProgressTimer* framerate;
@property(assign) CCSprite* framerateMarks;

+(FramerateIndicatorEntity *) create;

@end
