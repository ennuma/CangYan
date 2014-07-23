//
//  Extension.h
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright (c) 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "Wugong_SongFengJianFa.h"
//#import "Wugong_LuoHanFuMoGong.h"
//#import "Wugong_LiuMaiShenJian.h"
#import "Wugong.h"
#import "Place_XinShouCun.h"
@interface Extension : NSObject
{
    /**
    enum {
        kNameComponentHeroBody,
        kNameComponentAttackRange,
    }kName;
    **/
    #ifndef kNameComponent
    #define kNameComponent 1
    #define kNameComponentHeroBody @"herobody"
    #define kNameComponentAttackRange @"attackrange"
    #define kNameComponentSoldierCache @"soldiercache"
    #endif
    
    #ifndef kNameCache
    #define kNameCache 1
    #define kNameCacheMessage @"messageCahce"
    #define kNameCacheEnemy @"enemyCahce"
    #define kNameTiledMap @"tiledMap"
    #endif
}

@end

@interface CCSprite (Helper)

+(CCSprite*) spriteWithSpriteFrameName:(NSString*) name;

@end