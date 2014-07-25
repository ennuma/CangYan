//
//  Place_HeLuoKeZhan.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place_HeLuoKeZhan.h"
#import "CangYan.h"
#import "Event.h"
#import "Place_XinShouCun.h"
#import "Place_TianNingSi.h"
#import "Place_YanZiWu.h"
#import "Place_MeiZhuang.h"
#import "Event_LingHuVSQingCheng.h"
@implementation Place_HeLuoKeZhan
static int event_linghuvsqingcheng = 0;
-(bool)meetEvents
{
    CangYan* cangYan = [CangYan sharedScene];
    
    if ( _day==1 ) {
        if (event_linghuvsqingcheng==0) {
            event = [Event_LingHuVSQingCheng node];
            [event proceed];
            event_linghuvsqingcheng = 1;
            return true;
        }
    }
    
    return false;
}
-(NSMutableArray*)getNextPlaces
{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    Place_XinShouCun* one = [Place_XinShouCun node];
    Place_MeiZhuang* two = [Place_MeiZhuang node];
    Place_YanZiWu* three = [Place_YanZiWu node];
    Place_TianNingSi* four = [Place_TianNingSi node];
    [ret addObject:one];
    [ret addObject:two];
    [ret addObject:three];
    [ret addObject:four];
    return ret;
}
-(void)preparePlace
{
    _bg = [CCSprite spriteWithImageNamed:@"Place_XinShouChun.png"];
    _placeName = @"河洛客栈";
    
    
}
@end
