//
//  Bomb.m
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//

#import "Bomb.h"
#import "GrenadeGameAppDelegate.h"
#import "Game.h"

@implementation Bomb

+(id) bombWithGame:(Game*)game
{
	return [[[self alloc] initWithGame:game] autorelease];
}

+(id) bombWithGame:(Game*)game shape:(cpShape*)shape
{
	return [[[self alloc] initWithGame:game shape:shape] autorelease];
	
}

-(id) initWithGame:(Game*)game
{
	cpShape *shape = [game.spaceManager addCircleAt:cpvzero mass:STATIC_MASS radius:7];
    return [self initWithGame:game shape:shape];
}

-(id) initWithGame:(Game*)game shape:(cpShape*)shape;
{
	[super initWithShape:shape file:@"bomb.png"];
	
    GrenadeGameAppDelegate *mainDelegate = (GrenadeGameAppDelegate*)[[UIApplication sharedApplication]delegate];
    bombPower = [mainDelegate getBombPower];
    bombRadius = [mainDelegate getBombRadius];
	_game = game;
	_countDown = NO;
	
	//Free the shape when we are released
	self.spaceManager = game.spaceManager;
	self.autoFreeShape = YES;
	
	//Handle collisions
	shape->collision_type = kBombCollisionType;
	
	return self;
}

-(void) startCountDown
{
	//Only start it if we haven't yet
	if (!_countDown)
	{
		_countDown = YES;
		
		id f1 = [CCFadeTo actionWithDuration:.25 opacity:200];
		id f2 = [CCFadeIn actionWithDuration:.25];
		
		id d = [CCDelayTime actionWithDuration:3];
		id c = [CCCallFunc actionWithTarget:self selector:@selector(blowup)];
		
		[self runAction:[CCRepeatForever actionWithAction:[CCSequence actions:f1,f2,nil]]];
		[self runAction:[CCSequence actions:d,c,nil]];
	}
}

-(void) blowup
{
    
	[self.spaceManager applyLinearExplosionAt:self.position radius:bombRadius maxForce:bombPower];
	
	CCParticleSun *explosion = [[[CCParticleSun alloc] initWithTotalParticles:60] autorelease];
	explosion.position = self.position;
	explosion.duration = .5;
	explosion.speed = 40;
	explosion.autoRemoveOnFinish = YES;
	explosion.blendAdditive = NO;
	[_game addChild:explosion];
	[_game removeChild:self cleanup:YES];
}

@end
