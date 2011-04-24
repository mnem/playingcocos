//
//  BackgroundEntity.m
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "BackgroundEntity.h"

@implementation BackgroundEntity

+(BackgroundEntity *) create
{
	return [BackgroundEntity spriteWithFile: @"rainbowburst.png"];
}

-(void) fitToScreen
{
	CGSize win = [[CCDirector sharedDirector] winSizeInPixels];
	self.scaleX = win.width / self.contentSize.width;
	self.scaleY = win.height / self.contentSize.height;
}

-(id) initWithFile:(NSString*)filename
{
    self = [super initWithFile:filename];
    if (self) 
	{
		self.anchorPoint = ccp(0, 0);
		[self fitToScreen];
    }
    return self;
}


-(void) burst:(CGPoint) origin
{
	[self stopAllActions];

	id burst;
	burst = [CCTwirl actionWithPosition:origin twirls:1 amplitude:0.1 grid:ccg(16, 12) duration:0.6];//  actionWithPosition:origin radius:100 waves:10 amplitude:10 grid:ccg(16,12) duration:1];

	[self runAction: burst];
}

@end
