//
//  HelloWorldLayer.h
//  playingcocos
//
//  Created by David Wagner on 19/04/2011.
//  Copyright Noise & Heat 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

- (void) updateJitter;
- (void) spawnEmitter;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
