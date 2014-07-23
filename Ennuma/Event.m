//
//  Event.m
//  Ennuma
//
//  Created by ennuma on 14-7-23.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Event.h"
#import "CangYan.h"
@implementation Event
-(void)proceed
{
    CangYan* cangYan = [CangYan sharedScene];
    stage ++;
    switch (stage) {
        case 1:
            [cangYan.player say:@"一醉江湖三十春，安得书剑解红尘。"];
            break;
        
        case 2:
            
        default:
            break;
    }
}

@end
