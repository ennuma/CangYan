//
//  BattleField.h
//  Ennuma
//
//  Created by ennuma on 14-7-7.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Invader.h"
#import "hdEvent.h"

@interface BattleField : hdEvent {
    NSMutableArray* redTeam;
    NSMutableArray* blueTeam;
    
    NSMutableArray* whateverTeam;
    float interval;
    
    float maxJiQi;
    
    int _width;
    int _height;
    CCTiledMap* map;
    
    int tick;
    bool isExiting;
    
    bool waitForMove;
    bool waitForAttack;
    bool waitForChooseWugong;
    Wugong* choosedWugong;
    
    CGPoint lastloc;
}
+(BattleField*)scene;
-(void)startBattle;
-(void)addEntity:(Invader*) obj ForTeam:(NSString*) teamtype AtPos:(CGPoint)spawnPos;
-(void)notifyJiQiChangedForInvader:(Invader*) invader;
-(void)pauseAction;
-(void)resumeAction;
//-(void)waitForMove;
@property int width;
@property int height;
@property (nonatomic, strong) NSMutableSet * touches;
@end
