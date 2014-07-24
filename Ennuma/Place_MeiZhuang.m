//
//  Place_MeiZhuang.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place_MeiZhuang.h"
#import "Place_HeLuoKeZhan.h"
#import "CangYan.h"
#import "Event.h"

@implementation Place_MeiZhuang
-(bool)meetEvents
{
    CangYan* cangYan = [CangYan sharedScene];
    
    if ( _day==1 ) {
        event = [Event node];
        [event proceed];
        return true;
    }
    
    return false;
}
-(NSMutableArray*)getNextPlaces
{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    Place_HeLuoKeZhan* one = [Place_HeLuoKeZhan node];
    [ret addObject:one];
    return ret;
}
-(void)preparePlace
{
    _bg = [CCSprite spriteWithImageNamed:@"Place_XinShouChun.png"];
    _placeName = @"梅庄";
    
    
}

@end
