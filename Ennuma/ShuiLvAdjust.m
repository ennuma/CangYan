//
//  ShuiLvAdjust.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-5.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "ShuiLvAdjust.h"
#import "GuoJia.h"
@implementation ShuiLvAdjust
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    adjustRecords = [[NSMutableSet alloc] init];
    maxNumber = 100;
    [self initLayout];
    return self;
}
static ShuiLvAdjust* sharedShuiLv;
-(void)onEnter
{
    if ([adjustRecords containsObject:@"税率"]) {
        [[CCDirector sharedDirector]popScene];
    }
    [super onEnter];
}
+(ShuiLvAdjust*)sharedShuiLvAdjust
{
    if (sharedShuiLv) {
        return sharedShuiLv;
    }
    
    sharedShuiLv = [ShuiLvAdjust node];
    
    return sharedShuiLv;
}
-(void)resetAdjustRequest
{
    [adjustRecords removeAllObjects];
    slider.sliderValue = 0;
}
-(void)initLayout
{
    slider =  [CCSlider node];
    slider = [slider initWithBackground:[CCSpriteFrame frameWithImageNamed:@"hud.png"] andHandleImage:[CCSpriteFrame frameWithImageNamed:@"Player.png"] ];
    [self addChild:slider];
    slider.position = ccp(self.contentSize.width/2-slider.contentSize.width/2,self.contentSize.height/2);
    
    CCButton* confirm = [CCButton buttonWithTitle:@"确定调整税率"];
    [self addChild:confirm];
    confirm.position = ccp(slider.position.x,slider.position.y - 50);
    [confirm setTarget:self selector:@selector(buttonClicked:)];
    
    purchaseNumber = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",0] fontName:@"Chalkduster" fontSize:20];
    purchaseNumber.position = ccp(slider.position.x,slider.position.y+50+slider.contentSize.height);
    [self addChild:purchaseNumber];
    
    //requiredMoney = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",0] fontName:@"Chalkduster" fontSize:20];
    //requiredMoney.position = ccp(slider.position.x+slider.contentSize.width-requiredMoney.contentSize.width,slider.position.y+50+slider.contentSize.height);
    //[self addChild:requiredMoney];
}
-(void)buttonClicked:(id)button
{
    //CCButton* bt = button;
    if ([adjustRecords containsObject:@"税率"]) {
        [[CCDirector sharedDirector]popScene];
    }else{
        [adjustRecords addObject:@"税率"];
        int result = slider.sliderValue*maxNumber;
        
        GuoJia* guojia = [GuoJia sharedGuoJia];

        [guojia changeTaxTo:result];
        CCLOG(@"%i",result);
        [[CCDirector sharedDirector]popScene];
    }
}
-(void)update:(CCTime)delta
{
    //CCLOG(@"update %i",(int)slider.sliderValue*maxNumber);
    [purchaseNumber setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber)]];
    //[requiredMoney setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber*price)]];
}
@end
