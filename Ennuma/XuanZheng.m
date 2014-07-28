//
//  XuanZheng.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "XuanZheng.h"
#import "IntroScene.h"
#import "HuangDi.h"
@implementation XuanZheng
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    exit = [CCSprite spriteWithImageNamed:@"Hero.png"];
    exit.position = CGPointMake(exit.contentSize.width/2, exit.contentSize.height/2);
    [self addChild:exit];
    
    [self setUserInteractionEnabled:YES];
    return self;
}
+(CCScene*)scene
{
    return [[self alloc] init];
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    HuangDi* m_huangdi = [HuangDi sharedHuangDi];
    CGPoint touchpos = [touch locationInNode:self];
    CGRect exitbox = exit.boundingBox;
    exitbox.origin = [exit convertToWorldSpace:CGPointZero];
    if (CGRectContainsPoint(exitbox, touchpos)) {
        m_huangdi.tili = MAX(m_huangdi.tili-20,0);
        [[IntroScene sharedScene] passPhase];
        [[CCDirector sharedDirector] popScene];
    }
}
@end
