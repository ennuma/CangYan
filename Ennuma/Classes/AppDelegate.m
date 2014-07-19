//
//  AppDelegate.m
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright ennuma 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "GameScene.h"
#import "HelloWorldScene.h"
#import "WuLinScene.h"
#import "BattleField.h"
@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
	
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
    //return [WuLinScene scene];
    
    Invader* invader = [[Invader alloc]init];
    invader.attack=20;
    invader.armor = 15;
    invader.maxacume = 4800;
    invader.agile = 380;
    invader.maxhealth = 7000;
    
    //Battle
    BattleField* sc = [BattleField scene];
    [sc addEntity:invader ForTeam:@"red" AtPos:CGPointMake(1, 1)];
    
    Invader* invader2 = [[Invader alloc]init];
    invader2.attack=20;
    invader2.armor = 15;
    invader2.maxacume = 4800;
    invader2.agile=61;
    invader2.maxhealth=2100;
    [sc addEntity:invader2 ForTeam:@"blue" AtPos:CGPointMake(19, 19)];
    
    Invader* invader3 = [[Invader alloc]init];
    invader3.attack=20;
    invader3.armor = 15;
    invader3.maxacume = 4800;
    invader3.agile=61;
    invader3.maxhealth=2100;
    [sc addEntity:invader3 ForTeam:@"blue" AtPos:CGPointMake(19, 18)];
    
    Invader* invader4 = [[Invader alloc]init];
    invader4.attack=20;
    invader4.armor = 15;
    invader4.maxacume = 4800;
    invader4.agile=61;
    invader4.maxhealth=2100;
    [sc addEntity:invader4 ForTeam:@"blue" AtPos:CGPointMake(18, 18)];

    [sc startBattle];
    
    return sc;
}

@end
