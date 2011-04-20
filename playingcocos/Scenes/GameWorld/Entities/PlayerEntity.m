//
//  PlayerEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "PlayerEntity.h"


@implementation PlayerEntity

+(PlayerEntity *) create
{
	return [PlayerEntity spriteWithFile: @"player.png"];
}

//-(CGRect*) collisionRect
//{
//	return &self->collisionRect;
//}

//-(void) setPosition:(CGPoint)newPosition
//{
//	self->collisionRect.origin = newPosition;
//	super.position = newPosition;
//}


- (id)init 
{
    self = [super init];
    if (self) 
	{
//		self->collisionRect.size = CGSizeMake(16, 16);
		[self moveToStartPosition];
    }
    return self;
}

-(void) moveToStartPosition
{
	CGSize win = [[CCDirector sharedDirector] winSize];
	self.position = CGPointMake(win.width/2, win.height/2);
}

@end
