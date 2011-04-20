//
//  TargetEntity.h
//  playingcocos
//
//  Created by David Wagner on 20/04/2011.
//  Copyright 2011 Noise & Heat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TargetEntity : CCParticleSystemQuad
{    
}

-(void) respawn;


+(TargetEntity *) create;

@end
