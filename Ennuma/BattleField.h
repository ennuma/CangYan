//
//  BattleField.h
//  Ennuma
//
//  Created by ennuma on 14-7-7.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Invader.h"

@interface BattleField : CCScene {
    NSMutableArray* redTeam;
    NSMutableArray* blueTeam;
    
    NSMutableArray* whateverTeam;
    float interval;
    
    float maxJiQi;
    
    int _width;
    int _height;
    CCTiledMap* map;
    
    int tick;
}
+(BattleField*)scene;
-(void)startBattle;
-(void)addEntity:(Invader*) obj ForTeam:(NSString*) teamtype AtPos:(CGPoint)spawnPos;
-(void)notifyJiQiChangedForInvader:(Invader*) invader;
-(void)pauseAction;
-(void)resumeAction;
@property int width;
@property int height;
@end
