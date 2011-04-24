//
//  CCNode-Collision.m
//  playingcocos
//
//  Created by David Wagner on 24/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "CCNode-Collision.h"
#import <objc/runtime.h>

static char collisionBoxKey;

@implementation CCNode (Collision)

-(void) initCustomCollisionRect:(CGRect)rect
{
	CGRect* customSize = (CGRect*)objc_getAssociatedObject(self, &collisionBoxKey);
	if(!customSize)
	{
		customSize = malloc(sizeof(CGRect));
		objc_setAssociatedObject(self, &collisionBoxKey, (id)customSize, OBJC_ASSOCIATION_ASSIGN);
	}
	
	customSize->origin.x = rect.origin.x;
	customSize->origin.y = rect.origin.y;
	customSize->size.width = rect.size.width;
	customSize->size.height = rect.size.height;
}

-(void) deallocCustomCollisionRect
{
	CGRect* customSize = (CGRect*)objc_getAssociatedObject(self, &collisionBoxKey);
	if(customSize)
	{
		free(customSize);
		objc_setAssociatedObject(self, &collisionBoxKey, nil, OBJC_ASSOCIATION_ASSIGN);
	}
}

-(void) setCollisionRect:(CGRect*)rect
{
	CGRect* customSize = (CGRect*)objc_getAssociatedObject(self, &collisionBoxKey);
	if(customSize)
	{
		rect->origin.x = customSize->origin.x + self.position.x;
		rect->origin.y = customSize->origin.y + self.position.y;
		rect->size.width = customSize->size.width;
		rect->size.height = customSize->size.height;
	}
	else
	{
		rect->origin.x = self.position.x + self.contentSize.width * self.scaleX * self.anchorPoint.x;
		rect->origin.y = self.position.y + self.contentSize.height * self.scaleY * self.anchorPoint.y;
		rect->size.width = self.contentSize.width * self.scaleX;
		rect->size.height = self.contentSize.height * self.scaleY;
	}
}

-(BOOL) collidingWithNode:(CCNode*)node
{
	CGRect selfRect;
	CGRect otherRect;
	
	[self setCollisionRect:&selfRect];
	[node setCollisionRect:&otherRect];
	
	return CGRectIntersectsRect(selfRect, otherRect);
}

@end
