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
@implementation Place_XinShouCun
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
-(void)preparePlace
{
    _bg = [CCSprite spriteWithImageNamed:@"Place_XinShouChun.png"];
    [_nextPlaces addObject:self];
}
-(bool)proceed
{
    [event proceed];
    if(event.done==YES)
    {
        _canLeave = YES;
        return NO;
    }
    return YES;
}
@end
