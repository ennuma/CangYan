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
    NSMutableArray* _nextPlaces;
    bool _canLeave;
}
@property CCTiledMap* map;
@property int day;
@property CCSprite* bg;
@property NSMutableArray* nextPlaces;
@property bool canLeave;
-(void)enterPlaceOnDay:(int)day;
-(void)setBackGroundSprite:(CCSprite*)bg;
-(int)leavePlaceOnDay;
-(void)meetEvents;
-(void)preparePlace;
@end
