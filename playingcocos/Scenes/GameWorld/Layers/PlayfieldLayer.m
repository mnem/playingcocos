//
//  PlayfieldLayer.m
//  playingcocos
//
//  Created by David Wagner on 19/04/2011.
//  Copyright Noise & Heat 2011. All rights reserved.
//


// Import the interfaces
#import "PlayfieldLayer.h"
#import "CCTouchDispatcher.h"
#import "PlayerEntity.h"
#import "TargetEntity.h"
#import "BackgroundEntity.h"
#import "bitsnbobs.h"
#import "CCNode-Collision.h"
#import "FramerateIndicatorEntity.h"

#define ENABLE_BACKGROUND 0

#if ENABLE_BACKGROUND
BackgroundEntity *backgroundEntity;
#endif

PlayerEntity* playerEntity;
TargetEntity* targetEntity;
FramerateIndicatorEntity* framerate;

// PlayfieldLayer implementation
@implementation PlayfieldLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
#if ENABLE_BACKGROUND
		backgroundEntity = [BackgroundEntity create];
        [self addChild: backgroundEntity];
#endif
		framerate = [FramerateIndicatorEntity create];
		[self addChild:framerate];
		
		targetEntity = [TargetEntity create];
        [self addChild: targetEntity];
		
		playerEntity = [PlayerEntity create];
        [self addChild: playerEntity];
		playerEntity.targetPoint = (CGPoint*)malloc(sizeof(CGPoint));

		for (int i = 0; i < 99; i++)
		{
			PlayerEntity* ghost = [PlayerEntity create];
			ghost.targetPoint = playerEntity.targetPoint;
			[self addChild: ghost];
		}
		
		CGSize win = [[CCDirector sharedDirector] winSize];
		playerEntity.targetPoint->x = win.width/2;
		playerEntity.targetPoint->y = win.width/2;
		
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
	}
	
    return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
	CGPoint p = [self convertTouchToNodeSpace: touch];
	playerEntity.targetPoint->x = p.x;
	playerEntity.targetPoint->y = p.y;
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{
	CGPoint p = [self convertTouchToNodeSpace: touch];
	playerEntity.targetPoint->x = p.x;
	playerEntity.targetPoint->y = p.y;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
	CGPoint p = [self convertTouchToNodeSpace: touch];
	playerEntity.targetPoint->x = p.x;
	playerEntity.targetPoint->y = p.y;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void) update:(ccTime)dt
{
	if([playerEntity collidingWithNode:targetEntity])
	{
#if ENABLE_BACKGROUND
		[backgroundEntity burst:actualTarget];
#endif
		[targetEntity respawn];
	}
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	if(playerEntity.targetPoint) free(playerEntity.targetPoint);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
