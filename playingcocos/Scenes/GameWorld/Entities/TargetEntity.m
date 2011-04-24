//
//  TargetEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "TargetEntity.h"
#import "bitsnbobs.h"
#import "CCNode-Collision.h"

#define CONFIG @"particles.plist"
//#define CONFIG @"particles2.plist"

#define BORDER (25)
#define TWICE_BORDER (BORDER+BORDER)

@implementation TargetEntity

+(TargetEntity *) create
{
	return [TargetEntity particleWithFile: CONFIG];
}

-(id) initWithFile:(NSString *)plistFile
{
    self = [super initWithFile:plistFile];
    if (self) 
	{
		[self initCustomCollisionRect:CGRectMake(30, 18, 22, 16)];
		[self respawn];
    }
    return self;
}

- (void)dealloc {
	[self deallocCustomCollisionRect];
    [super dealloc];
}

-(void) respawn
{
	CGSize win = [[CCDirector sharedDirector] winSize];
	CGFloat x = ((win.width - TWICE_BORDER) * nrand()) + BORDER;
	CGFloat y = ((win.height - TWICE_BORDER) * nrand()) + BORDER;

	[self resetSystem];

	self.position = CGPointMake(x, y);
}

@end
