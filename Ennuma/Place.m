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
//@synthesize nextPlaces = _nextPlaces;
@synthesize canLeave = _canLeave;
@synthesize placeName = _placeName;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
   // _nextPlaces = [[NSMutableArray alloc]init];
    [self preparePlace];
    return self;
}
-(NSMutableArray*)getNextPlaces
{
    return nil;
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
    //[self removeFromParent];
    return _day;
}
-(bool)meetEvents
{
    return NO;
}
-(bool)proceed
{
    if (event) {
        [event proceed];
        if(event.done==YES)
        {
            _canLeave = YES;
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
}

@end
