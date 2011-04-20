//
//  PlayerEntity.h
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerEntity : CCSprite
{
//    CGRect collisionRect;
}

//@property (readonly) CGRect* collisionRect;

-(void) moveToStartPosition;

+(PlayerEntity *) create;

@end
