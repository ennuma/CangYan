//
//  Place.h
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Place : CCNode {
    CCTiledMap* _map;
    CCSprite* _bg;
    int _day;
}
@property CCTiledMap* map;
@property int day;
@property CCSprite* bg;
-(void)enterPlaceOnDay:(int)day;
-(void)setBackGroundSprite:(CCSprite*)bg;
-(int)leavePlaceOnDay;
@end
