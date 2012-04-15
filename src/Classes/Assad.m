//
//  Assad.m
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//

#import "Assad.h"
#import "Game.h"

@implementation Assad

+(id) assadWithGame:(Game*)game
{
	return [[[self alloc] initWithGame:game] autorelease];
}

+(id) assadWithGame:(Game*)game shape:(cpShape*)shape
{
	return [[[self alloc] initWithGame:game shape:shape] autorelease];	
}

-(id) initWithGame:(Game*)game
{
	cpShape *shape = [game.spaceManager addCircleAt:cpvzero mass:50 radius:10];
	return [self initWithGame:game shape:shape];
    
    GrenadeGameAppDelegate *mainDelegate = (GrenadeGameAppDelegate*)[[UIApplication sharedApplication]delegate];
    MAX_DAMAGE = [mainDelegate getassadResistance];
}

-(id) initWithGame:(Game*)game shape:(cpShape*)shape;
{
	[super initWithShape:shape file:@"assad.png"];
	
	_game = game;
	
	//Free the shape when we are released
	self.spaceManager = game.spaceManager;
	self.autoFreeShape = YES;
	
	//Handle collisions
	shape->collision_type = kAssadCollisionType;
	
	return self;
}

-(void) addDamage:(int)damage
{
	_damage += damage;
	
    
	if (_damage > MAX_DAMAGE)
	{
		[_game enemyKilled];
		
		CCSprite *poof = [CCSprite spriteWithFile:@"poof.png"];
		[_game addChild:poof z:10];
		poof.scale = .1;
		poof.position = self.position;
		id s = [CCEaseBounceOut actionWithAction:[CCScaleTo actionWithDuration:1 scale:1]];
		id d = [CCDelayTime actionWithDuration:.3];
		id f = [CCFadeOut actionWithDuration:.7];
		
		[poof runAction:[CCSequence actions:s,d,f,nil]];
		[_game removeChild:self cleanup:YES];
	}
}

@end
