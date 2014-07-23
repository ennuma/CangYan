//
//  Place.m
//  Ennuma
//
//  Created by ennuma on 14-7-22.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place.h"


@implementation Place
@synthesize day = _day;
@synthesize bg = _bg;
@synthesize map = _map;
-(void)enterPlaceOnDay:(int)day
{
    _day = day;
}
-(void)setBackGroundSprite:(CCSprite *)bg
{
    _bg = bg;
}
-(int)leavePlaceOnDay
{
    return _day;
}
@end
