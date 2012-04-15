//
//  GameConfig.h
//
//  Created by Frederic Jacobs on 14/4/12.
//  Copyleft !!! 
//
#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

// Collision Defines
#define kAssadCollisionType		1
#define kShabihaCollisionType	1
#define kGroundCollisionType	2
#define kBlockCollisionType		3
#define kBombCollisionType		4

//tags
#define GAME_TAG	1

//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationUIViewController


#endif // __GAME_CONFIG_H