//
//  GrenadeGameAppDelegate.h
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class RootViewController;

@interface GrenadeGameAppDelegate : NSObject <UIApplicationDelegate, AVAudioPlayerDelegate> {
	UIWindow			*window;
    AVAudioPlayer *audioPlayer;
	RootViewController	*viewController;
    NSString            *username;
    NSInteger numberOfEnemies;
    NSInteger numberOfBombs;
    int bombRadius;
    int bombPower;
    int assadResistance;
}

@property (nonatomic, retain) UIWindow *window;


- (NSString *) getUsername;
- (void) setUsername: (NSString *) usernamA;

- (void) setNumberOfEnnemies: (NSInteger)numberOfEnnemA;
- (void) setNumberOfBombs: (NSInteger)numberOfBombA;
- (void) setBombRadius: (NSInteger)bombRadA;
- (void) setBombPower: (NSInteger)bombPowA;
- (void) setassadResistance: (float)assadResistA;

- (NSInteger) getNumberOfEnnemies;
- (NSInteger) getNumberOfBombs;
- (NSInteger) getBombRadius;
- (NSInteger) getBombPower;
- (float) getassadResistance;

- (NSInteger) getScore ; 
- (BOOL) isHighScore:(NSInteger) score;



@end
