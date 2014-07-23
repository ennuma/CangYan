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
@synthesize nextPlaces = _nextPlaces;
@synthesize canLeave = _canLeave;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self preparePlace];
    return self;
}
-(void)preparePlace
{

}
-(bool)enterPlaceOnDay:(int)day
{
    _day = day;
    return [self meetEvents];
}
-(void)setBackGroundSprite:(CCSprite *)bg
{
    _bg = bg;
}
-(int)leavePlaceOnDay
{
    return _day;
}
-(bool)meetEvents
{

}
-(void)proceed
{

}
@end
