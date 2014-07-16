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
}
+(BattleField*)scene;

-(void)addEntity:(Invader*) obj ForTeam:(NSString*) teamtype;
@property int width;
@property int height;
@end
