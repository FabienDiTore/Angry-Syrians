//
//  GrenadeGameAppDelegate.m
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//

#import "cocos2d.h"

#import "GrenadeGameAppDelegate.h"
#import "GameConfig.h"
#import "Game.h"
#import "RootViewController.h"

@implementation GrenadeGameAppDelegate

@synthesize window;




- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	
	//	CC_ENABLE_DEFAULT_GL_STATES();
	//	CCDirector *director = [CCDirector sharedDirector];
	//	CGSize size = [director winSize];
	//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	//	sprite.position = ccp(size.width/2, size.height/2);
	//	sprite.rotation = -90;
	//	[sprite visit];
	//	[[director openGLView] swapBuffers];
	//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alertshown = [defaults stringForKey:@"alertshown"]; {
        if (alertshown == nil) {
            
            
            UIAlertView *oneTimeWelcome = [[UIAlertView alloc]
                                           initWithTitle: @"Welcome"
                                           message: @"This is beta-software. Can Crash"
                                           delegate: self
                                           cancelButtonTitle:@"Play Now"
                                           otherButtonTitles:nil];

            [oneTimeWelcome show];
            [oneTimeWelcome release];
            
            
            
            [defaults setObject:@"alertwasdisplayed" forKey:@"alertshown"];
            [defaults setObject:@"3" forKey:@"numberOfBombs"];
            [defaults setObject:@"5" forKey:@"numberOfEnemies"];
            [defaults setObject:@"6000" forKey:@"bombPower"];
            [defaults setObject:@"120" forKey:@"bombRadius"];
            [defaults setObject:@"2" forKey:@"assadResistance"];
            int score = 0 ;
            [defaults setObject:[NSString stringWithFormat:@"%i", score] forKey:@"HighScore"];
            
        } 
        
    
        numberOfBombs = [defaults stringForKey:@"numberOfBombs"].intValue;
        numberOfEnemies = [defaults stringForKey:@"numberOfEnemies"].intValue;
        bombPower = [defaults stringForKey:@"bombPower"].intValue;
        bombRadius = [defaults stringForKey:@"bombRadius"].intValue;
        assadResistance = [defaults stringForKey:@"assadResistance"].floatValue;
    }
    

    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"ThirteenSenses-IntoTheFire"
                                         ofType:@"m4a"]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:url
                   error:&error];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", 
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        [audioPlayer setNumberOfLoops:-1];
        [audioPlayer play];
        
    }

	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	//[director setDisplayFPS:YES];
	[director enableRetinaDisplay:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [Game scene]];		
}

- (void) setUsername: (NSString *) usernamA{
    username = usernamA;
}

- (NSString *) getUsername {
    if (username == nil){
        username = @"You";
        return username;
    }
    else {
        return username;

    }
}

-(NSInteger) getScore {
    float score =  (100*((0.1 * assadResistance)+(bombPower/6000)-(0.1 * numberOfBombs)+(0.3 * numberOfEnemies)));
    NSInteger scoreInt = (int) score;
    return scoreInt;
}

- (BOOL) isHighScore: (NSInteger) score {
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger currentHighscore = [defaults stringForKey:@"HighScore]"].intValue;  
    
    if (currentHighscore < score){
        
    [defaults setObject:[NSString stringWithFormat:@"%i", score] forKey:@"HighScore"];
        return YES;
    }
    else {
        return NO;
    }
    
}
    

- (void) setNumberOfEnnemies: (NSInteger)numberOfEnnemA{
    numberOfEnemies = numberOfEnnemA;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%i", numberOfEnemies] forKey:@"numberOfEnemies"];
}

- (void) setNumberOfBombs: (NSInteger)numberOfBombA{
    
    numberOfBombs = numberOfBombA;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%i", numberOfBombs] forKey:@"numberOfBombs"];
}

- (void) setBombRadius: (NSInteger)bombRadA{
    bombRadius = bombRadA;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%i", bombRadius] forKey:@"bombRadius"];

}
- (void) setBombPower: (NSInteger)bombPowA{

    bombPower = bombPowA;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%i", bombPower] forKey:@"bombPower"];

}

- (void) setassadResistance: (float)assadResistA{
    
    assadResistance = assadResistA;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%f", assadResistance] forKey:@"assadResistance"];
    
}

- (NSInteger) getNumberOfEnnemies{
    
    return numberOfEnemies;
}

- (NSInteger) getNumberOfBombs{
    
    return numberOfBombs;
}

- (NSInteger) getBombRadius {
    return bombRadius;
}
- (NSInteger) getBombPower{
    
    return bombPower;
}
- (float) getassadResistance{
    
    return assadResistance;
}


- (void)applicationWillResignActive:(UIApplication *)application {	
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {	
	[(Game*)[[[CCDirector sharedDirector] runningScene] getChildByTag:GAME_TAG] save];

	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
