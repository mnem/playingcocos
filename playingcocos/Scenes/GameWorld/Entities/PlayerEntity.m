//
//  PlayerEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "PlayerEntity.h"
#import "CCNode-Collision.h"

@implementation PlayerEntity

+(PlayerEntity *) create
{
	return [PlayerEntity spriteWithFile: @"player.png"];
}

- (id)init 
{
    self = [super init];
    if (self) 
	{
//		[self initCustomCollisionSize:CGSizeMake(16, 16)];
		[self moveToStartPosition];
    }
    return self;
}

- (void)dealloc {
//    [self deallocCustomCollisionSize];
    [super dealloc];
}

-(void) moveToStartPosition
{
	CGSize win = [[CCDirector sharedDirector] winSize];
	self.position = ccp(win.width/2, win.height/2);
}

@end
