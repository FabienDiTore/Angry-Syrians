//
//  SettingsViewController.m
//  Angry Syrians
//
//  Created by Frederic Jacobs on 14/04/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import "SettingsViewController.h"
#import "GrenadeGameAppDelegate.h"
#import "Game.h"



@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize numberOfBombsSlider, numberOfEnemiesSlider, bombPowerSlider,bombRadiusSlider, assadRessistanceSlider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    GrenadeGameAppDelegate *mainDelegate = (GrenadeGameAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    numberOfBombs = [mainDelegate getNumberOfBombs];
    numberOfEnemies = [mainDelegate getNumberOfEnnemies];
    bombPower = [mainDelegate getBombPower];
    bombRadius = [mainDelegate getBombRadius];
    assadResistance = [mainDelegate getassadResistance];
    
    numberOfBombsSlider.value = numberOfBombs;
    numberOfEnemiesSlider.value = numberOfEnemies;
    bombPowerSlider.value = bombPower;
    bombRadiusSlider.value = bombRadius;
    assadRessistanceSlider.value = assadResistance;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneEditing:(id)sender{

    GrenadeGameAppDelegate *mainDelegate = (GrenadeGameAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    numberOfBombs= numberOfBombsSlider.value;
    numberOfEnemies = numberOfEnemiesSlider.value;
    bombPower = bombPowerSlider.value;
    bombRadius = bombRadiusSlider.value;
    assadResistance = assadRessistanceSlider.value;
    
    
    [mainDelegate setNumberOfBombs:numberOfBombs];
    [mainDelegate setNumberOfEnnemies:numberOfEnemies];
    [mainDelegate setBombPower:bombPower];
    [mainDelegate setBombRadius:bombRadius];
    
    [(Game*)[[[CCDirector sharedDirector] runningScene] getChildByTag:GAME_TAG] dismissSettings];
    
    
}

@end
