//
//  ComponentAttackRange.m
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "ComponentAttackRange.h"
#import "ComponentHeroBody.h"
#import "Extension.h"

@implementation ComponentAttackRange
-(id)init
{
    self = [super init];
    if (!self) return nil;
    
    range = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Range.png"]];
    
    
    
    [self addChild:range];
    return self;
}
+(ComponentAttackRange*)component
{
    return [[self alloc]init];
}

-(void)reset
{
    CCNode* parent = [self parent];
    //set the position of attackrange according to parent node position
    float radiusdif = ([range boundingBox].size.height - [((ComponentHeroBody*)[parent getChildByName:kNameComponentHeroBody recursively:NO]).heroBody boundingBox].size.height)/2;
    range.position = CGPointMake(parent.position.x, parent.position.y+radiusdif);
}
@end
