//
//  Place_YanZiWu.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place_YanZiWu.h"
#import "CangYan.h"
#import "Event.h"
#import "Place_HeLuoKeZhan.h"

@implementation Place_YanZiWu
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
    _placeName = @"燕子坞";
    
    
}

@end
