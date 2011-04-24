//
//  CCNode-Collision.h
//  playingcocos
//
//  Created by David Wagner on 24/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface CCNode (Collision)

-(void) initCustomCollisionRect:(CGRect)rect;
-(void) deallocCustomCollisionRect;

-(BOOL) collidingWithNode:(CCNode*)node;

@end
