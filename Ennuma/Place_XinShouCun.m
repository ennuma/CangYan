//
//  Place_XinShouCun.m
//  Ennuma
//
//  Created by ennuma on 14-7-23.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place_XinShouCun.h"
#import "CangYan.h"
#import "Event.h"
#import "Place_HeLuoKeZhan.h"
#import "Place_FuWeiBiaoJv.h"
@implementation Place_XinShouCun
static int event_basictype = 0;
-(bool)meetEvents
{
    CangYan* cangYan = [CangYan sharedScene];

    if ( _day==1 ) {
        if (event_basictype==0) {
            event = [Event node];
            [event proceed];
            event_basictype = 1;
            return true;
        }
    }
    
    return false;
}
-(NSMutableArray*)getNextPlaces
{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    Place_HeLuoKeZhan* one = [Place_HeLuoKeZhan node];
    Place_FuWeiBiaoJv* two = [Place_FuWeiBiaoJv node];
    [ret addObject:one];
    [ret addObject:two];
    return ret;
}
-(void)preparePlace
{
    _bg = [CCSprite spriteWithImageNamed:@"Place_XinShouChun.png"];
    _placeName = @"新手村";
    

}

@end
