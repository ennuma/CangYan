//
//  CangYanMain.h
//  Ennuma
//
//  Created by ennuma on 14-7-23.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CangYanMain : CCScene {
    int _day;
    Entity* _player;
}
@property int day;
@property Entity* player;
+(CangYan*)scene;
+(CangYan*)sharedScene;
@end
