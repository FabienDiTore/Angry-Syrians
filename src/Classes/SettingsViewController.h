//
//  SettingsViewController.h
//  Angry Syrians
//
//  Created by Frederic Jacobs on 14/04/12.
//  Copyright (c) 2012 Evolucix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>{
    
    NSString *username;
    NSInteger numberOfEnemies;
    NSInteger numberOfBombs;
    float bombRadius;
    float bombPower;
    float assadResistance;
    
    IBOutlet UISlider *numberOfEnemiesSlider;
    IBOutlet UISlider *numberOfBombsSlider;
    IBOutlet UISlider *bombRadiusSlider;
    IBOutlet UISlider *bombPowerSlider;
    IBOutlet UISlider *assadRessistanceSlider;
    
    
 // ADD HIGHSCORE IF TIME   
}

- (IBAction)doneEditing:(id)sender;


@property (nonatomic,retain)IBOutlet UISlider *numberOfEnemiesSlider;
@property (nonatomic,retain)IBOutlet UISlider *numberOfBombsSlider;
@property (nonatomic,retain)IBOutlet UISlider *bombRadiusSlider;
@property (nonatomic,retain)IBOutlet UISlider *bombPowerSlider;
@property (nonatomic,retain)IBOutlet UISlider *assadRessistanceSlider;


@end
