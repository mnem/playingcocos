//
//  GameWorldSceneFactory.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "GameWorldSceneFactory.h"
#import "PlayfieldLayer.h"

@implementation GameWorldSceneFactory

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PlayfieldLayer *layer = [PlayfieldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

@end
