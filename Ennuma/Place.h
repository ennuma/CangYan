//
//  Place.h
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Event.h"
@interface Place : CCNode {
    CCTiledMap* _map;
    CCSprite* _bg;
    int _day;
    //NSMutableArray* _nextPlaces;
    bool _canLeave;
    Event* event;
    NSString* _placeName;
}
@property CCTiledMap* map;
@property int day;
@property CCSprite* bg;
//@property NSMutableArray* nextPlaces;
@property bool canLeave;
@property NSString* placeName;
-(bool)enterPlaceOnDay:(int)day;
-(void)setBackGroundSprite:(CCSprite*)bg;
-(int)leavePlaceOnDay;
-(bool)meetEvents;
-(void)preparePlace;
-(bool)proceed;
-(NSMutableArray*)getNextPlaces;
@end
