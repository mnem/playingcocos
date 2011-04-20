//
//  TargetEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "TargetEntity.h"
#import "bitsnbobs.h"

#define CONFIG @"particles.plist"
//#define CONFIG @"particles.plist"

#define BORDER (25)
#define TWICE_BORDER (BORDER+BORDER)

@implementation TargetEntity

+(TargetEntity *) create
{
	return [TargetEntity particleWithFile: CONFIG];
}

- (id)init 
{
    self = [super init];
    if (self) 
	{
		[self respawn];
    }
    return self;
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
