//
//  FramerateIndicatorEntity.m
//  playingcocos
//
//  Created by David Wagner on 26/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "FramerateIndicatorEntity.h"

@implementation FramerateIndicatorEntity

@synthesize framerate;
@synthesize framerateMarks;

+(FramerateIndicatorEntity *) create
{
	return [FramerateIndicatorEntity node];
}

- (id)init 
{
    self = [super init];
    if (self) 
	{
		self.framerate = [CCProgressTimer progressWithFile:@"framrate-indicator.png"];
		self.framerate.anchorPoint = ccp(0, 1);
		self.framerate.type = kCCProgressTimerTypeHorizontalBarLR;
		self.framerate.percentage = 100;
		[self addChild:self.framerate];
		
		self.framerateMarks = [CCSprite spriteWithFile:@"framrate-indicator-marks.png"];
		self.framerateMarks.anchorPoint = ccp(0, 1);
		[self addChild:self.framerateMarks];
		
		self.position = ccp(0, 320);
		
		[self scheduleUpdate];
    }
    return self;
}

- (void) update:(ccTime)dt
{
	ccTime fr = [CCDirector sharedDirector].frameRate;
	CGFloat percent = fr / 60 * 100;
	if(percent < 1) percent = 1;
	if(percent > 100) percent = 100;
	self.framerate.percentage = percent;
}

@end
