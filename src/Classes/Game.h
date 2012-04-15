//
//  Serialize.h
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//

#import "SpaceManagerCocos2d.h"
#import "GameConfig.h"
#import "Bomb.h"
#import "SettingsViewController.h"
#import "GrenadeGameAppDelegate.h"

@interface Game : CCLayer<SpaceManagerSerializeDelegate>
{
	SpaceManagerCocos2d *smgr;
	
	NSMutableArray	*_bombs;
	Bomb			*_curBomb;
    SettingsViewController *settingsView;
    NSInteger numberOfEnemies;
    
    NSInteger numberOfBombs;
    
	
	int _enemiesLeft;
}

@property (readonly) SpaceManager* spaceManager;
@property (retain, nonatomic) SettingsViewController *settingsView;

+(id) scene;
-(id) initWithSaved:(BOOL)loadIt;
-(void)dismissSettings;


-(BOOL) aboutToReadShape:(cpShape*)shape shapeId:(long)id;
-(void) save;
-(void) enemyKilled;

@end

