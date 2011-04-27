//
//  PlayerEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "PlayerEntity.h"
#import "CCNode-Collision.h"
#import "bitsnbobs.h"

const int JITTER = 132;
const int HALF_JITTER = 132/2;

@interface PlayerEntity ()

- (void) updateJitter;

@end

@implementation PlayerEntity

@synthesize jitterPoint;
@synthesize targetPoint;
@synthesize jitterUpdateDelay;

+(PlayerEntity *) create
{
	return [PlayerEntity spriteWithFile: @"player.png"];
}

- (id)init 
{
    self = [super init];
    if (self) 
	{
		self.jitterPoint = (CGPoint*)malloc(sizeof(CGPoint));
		self.jitterUpdateDelay = 0;
		[self moveToStartPosition];
        [self scheduleUpdate];
    }
    return self;
}

- (void) updateJitter
{
	float framerate = 1/[CCDirector sharedDirector].animationInterval;
	float frThird = framerate / 3;
    self.jitterUpdateDelay = frThird + frThird * nrand();
    self.jitterPoint->x = nrand() * JITTER - HALF_JITTER;
    self.jitterPoint->y = nrand() * JITTER - HALF_JITTER;
}

- (void) update:(ccTime)dt
{
    if (--self.jitterUpdateDelay <= 0) 
	{
        [self updateJitter];
    }
    
	CGPoint actualTarget = CGPointMake(self.targetPoint->x + self.jitterPoint->x, self.targetPoint->y + self.jitterPoint->y);
	self.position = ccpLerp(self.position, actualTarget, 0.1f);
}

- (void)dealloc 
{
	if(self.jitterPoint) free(self.jitterPoint);
    [super dealloc];
}

-(void) moveToStartPosition
{
	CGSize win = [[CCDirector sharedDirector] winSize];
	self.position = ccp(win.width/2, win.height/2);
}

@end
