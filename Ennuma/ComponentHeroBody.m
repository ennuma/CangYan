//
//  ComponentHeroBody.m
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "ComponentHeroBody.h"
#import "Extension.h"


@implementation ComponentHeroBody
@synthesize heroBody = _heroBody;
-(id)init
{
    self = [super init];
    if(!self) return nil;
    
    CCNode* parent = [self parent];
    //_heroBody = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Hero.png"]];
    //CCLOG(@"component");
    _heroBody = [Hero hero];
    [self addChild:_heroBody];
    
    return self;
}
+(ComponentHeroBody*)component
{
    return [[self alloc] init];
}
@end
