//
//  HelloWorldLayer.m
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
#import "bitsnbobs.h"

PlayerEntity *player;
TargetEntity *target;

const int JITTER = 33;
const int HALF_JITTER = 33/2;

CGPoint jitterPoint;
int updateJitter;

CGPoint targetPoint;

// PlayfieldLayer implementation
@implementation PlayfieldLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
		player = [PlayerEntity create];
		target = [TargetEntity create];
		
        [self addChild: player];
        [self addChild: target];
		
		[self updateJitter];
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
	}
	
    return self;
}

- (void) updateJitter
{
	float framerate = 1/[CCDirector sharedDirector].animationInterval;
	float frThird = framerate / 3;
    updateJitter = frThird + frThird * nrand();
    jitterPoint.x = nrand() * JITTER - HALF_JITTER;
    jitterPoint.y = nrand() * JITTER - HALF_JITTER;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    targetPoint = [self convertTouchToNodeSpace: touch];
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{
    targetPoint = [self convertTouchToNodeSpace: touch];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
    targetPoint = [self convertTouchToNodeSpace: touch];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void) update:(ccTime)dt
{
    if (--updateJitter <= 0) 
	{
        [self updateJitter];
    }
    
	CGPoint actualTarget = CGPointMake(targetPoint.x + jitterPoint.x, targetPoint.y + jitterPoint.y);
	player.position = ccpLerp(player.position, actualTarget, 0.1f);
	
	CGRect collisionRect = CGRectMake(target.position.x - 8, target.position.y - 8, 16, 16);
	if(CGRectContainsPoint(collisionRect, player.position))
	{
		[target respawn];
	}
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
