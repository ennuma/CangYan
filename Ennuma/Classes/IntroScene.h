//
//  IntroScene.h
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright ennuma 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene
{
    CGRect xuanzheng;
    CGRect hougong;
    CGRect baixiyuan;
    CGRect wudaochang;
    int day;
    int time; //1 morning, 2 afternoon, 3 night, 4 sleeptime
    
    CCScene* eventScene;
}

// -----------------------------------------------------------------------
@property int m_day;
@property int m_time;
+ (IntroScene *)scene;
+(IntroScene*)sharedScene;
- (id)init;
-(void)passPhase;
// -----------------------------------------------------------------------
@end