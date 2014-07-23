//
//  CangYan.h
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "Extension.h"
@interface CangYan : CCScene {
    int _day;
    Entity* _player;
    Place* _place;
    bool inPlace;
}
@property int day;
@property Entity* player;
@property Place* place;
+(CangYan*)scene;
+(CangYan*)sharedScene;
@end
