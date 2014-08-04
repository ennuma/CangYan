//
//  BaiXiYuan.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-4.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "BaiXiYuan.h"
#import "HuangDi.h"
#import "IntroScene.h"
@implementation BaiXiYuan
+(BaiXiYuan*)scene
{
    BaiXiYuan* ret = [[self alloc]init];
    return ret;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //init animation
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    confirm.position = ccp(self.contentSize.width/2-confirm.contentSize.width/2,self.contentSize.height/2-30);
    [self addChild:confirm];
    [confirm setTarget:self selector:@selector(pressButton:)];
    
    incOfZhili = 0;
    return self;
}
-(void)pressButton:(id)button
{
    CCLOG(@"exit baixiyuan");
    [HuangDi sharedHuangDi].zhili += incOfZhili;
    [[IntroScene sharedScene] passPhase];
    [[CCDirector sharedDirector]popScene];
}
-(void)onEnter
{
    //play animation
    //change inc of wuli
    incOfZhili = 5;
    
    [super onEnter];
}
@end
