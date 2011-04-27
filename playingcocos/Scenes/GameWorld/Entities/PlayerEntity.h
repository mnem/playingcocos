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
	CGPoint *targetPoint;
	CGPoint *jitterPoint;
	int jitterUpdateDelay;
}

@property(nonatomic) CGPoint* targetPoint;
@property(nonatomic) CGPoint* jitterPoint;
@property(nonatomic) int jitterUpdateDelay;

-(void) moveToStartPosition;

+(PlayerEntity *) create;

@end
