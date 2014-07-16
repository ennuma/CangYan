//
//  Extension.m
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright (c) 2014年 ennuma. All rights reserved.
//

#import "Extension.h"

@implementation Extension

@end

@implementation CCSprite (Helper)

+(CCSprite*) spriteWithSpriteFrameName:(NSString*) name
{
    return [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"fire.on.png"]];
}

@end