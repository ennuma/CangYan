//
//  Place_FuWeiBiaoJv.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Place_FuWeiBiaoJv.h"
#import "CangYan.h"
#import "Event.h"
#import "Place_XinShouCun.h"
@implementation Place_FuWeiBiaoJv
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
    Place_XinShouCun* one = [Place_XinShouCun node];
    [ret addObject:one];
    return ret;
}
-(void)preparePlace
{
    _bg = [CCSprite spriteWithImageNamed:@"Place_XinShouChun.png"];
    _placeName = @"福威镖局";
    
    
}

@end
