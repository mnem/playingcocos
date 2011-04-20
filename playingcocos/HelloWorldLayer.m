//
//  HelloWorldLayer.m
//  playingcocos
//
//  Created by David Wagner on 19/04/2011.
//  Copyright Noise & Heat 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"

CCSprite *player_png;
CCParticleSystemQuad *emitter;

const int JITTER = 33;
const int HALF_JITTER = 33/2;

CGPoint jitterPoint;
int updateJitter;

CGPoint targetPoint;

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        CGSize win = [[CCDirector sharedDirector] winSize];
        targetPoint = CGPointMake(win.width/2, win.height/2);
        
        player_png = [CCSprite spriteWithFile: @"player.png"];
        player_png.position = targetPoint;
        [self addChild:player_png];
		
		emitter = [CCParticleSystemQuad particleWithFile: @"particles.plist"];
//		emitter = [CCParticleSystemQuad particleWithFile: @"particles2.plist"];
        [self addChild:emitter];
		[self spawnEmitter];
        
		[self updateJitter];
        [self schedule:@selector(nextFrame:)];
        self.isTouchEnabled = YES;
	}
	
    return self;
}

float nrand()
{
	return (float)rand() / RAND_MAX;
}

- (void) updateJitter
{
	float framerate = 1/[CCDirector sharedDirector].animationInterval;
	float frThird = framerate / 3;
    updateJitter = frThird + frThird * nrand();
    jitterPoint.x = nrand() * JITTER - HALF_JITTER;
    jitterPoint.y = nrand() * JITTER - HALF_JITTER;
}

- (void) spawnEmitter
{
	CGSize win = [[CCDirector sharedDirector] winSize];
	emitter.position = CGPointMake(((win.width - 50) * nrand()) + 25, ((win.height - 50) * nrand()) + 25);
	[emitter resetSystem];
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

- (void) nextFrame:(ccTime)dt
{
    if (--updateJitter <= 0) 
	{
        [self updateJitter];
    }
    
	CGPoint actualTarget = CGPointMake(targetPoint.x + jitterPoint.x, targetPoint.y + jitterPoint.y);
	player_png.position = ccpLerp(player_png.position, actualTarget, 0.1f);
	
	CGRect collisionRect = CGRectMake(emitter.position.x - 8, emitter.position.y - 8, 16, 16);
	if(CGRectContainsPoint(collisionRect, player_png.position))
	{
		[self spawnEmitter];
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
