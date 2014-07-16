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
    invader.strength=20;
    invader.jiqispeed = 120;
    invader.health = 500;
    
    //Battle
    BattleField* sc = [BattleField scene];
    [sc addEntity:invader ForTeam:@"red"];
    
    Invader* invader2 = [[Invader alloc]init];
    invader2.strength=20;
    invader2.jiqispeed = 180;
    invader2.agile=61;
    invader2.health=210;
    [sc addEntity:invader2 ForTeam:@"blue"];
    
    return sc;
}

@end
