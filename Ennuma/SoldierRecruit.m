//
//  SoldierRecruit.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-4.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "SoldierRecruit.h"
#import "GuoJia.h"
@implementation SoldierRecruit
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    purchaseRecords = [[NSMutableSet alloc] init];
    price = 200;
    [self initLayout];
    return self;
}
static SoldierRecruit* sharedSoldierRecruit;
-(void)onEnter
{
    if ([purchaseRecords containsObject:@"士兵"]) {
        [[CCDirector sharedDirector]popScene];
    }
    maxNumber = [[GuoJia sharedGuoJia]getMaxSoldierRecruitNum];
    [super onEnter];
}
+(SoldierRecruit*)sharedSoldierRecruit
{
    if (sharedSoldierRecruit) {
        return sharedSoldierRecruit;
    }
    
    sharedSoldierRecruit = [SoldierRecruit node];
    
    return sharedSoldierRecruit;
}
-(void)resetPurchaseRequest
{
    [purchaseRecords removeAllObjects];
    slider.sliderValue = 0;
}
-(void)initLayout
{
    slider =  [CCSlider node];
    slider = [slider initWithBackground:[CCSpriteFrame frameWithImageNamed:@"hud.png"] andHandleImage:[CCSpriteFrame frameWithImageNamed:@"Player.png"] ];
    [self addChild:slider];
    slider.position = ccp(self.contentSize.width/2-slider.contentSize.width/2,self.contentSize.height/2);
    
    CCButton* confirm = [CCButton buttonWithTitle:@"确定购买"];
    [self addChild:confirm];
    confirm.position = ccp(slider.position.x,slider.position.y - 50);
    [confirm setTarget:self selector:@selector(buttonClicked:)];
    
    purchaseNumber = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",0] fontName:@"Chalkduster" fontSize:20];
    purchaseNumber.position = ccp(slider.position.x,slider.position.y+50+slider.contentSize.height);
    [self addChild:purchaseNumber];
    
    requiredMoney = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",0] fontName:@"Chalkduster" fontSize:20];
    requiredMoney.position = ccp(slider.position.x+slider.contentSize.width-requiredMoney.contentSize.width,slider.position.y+50+slider.contentSize.height);
    [self addChild:requiredMoney];
}
-(void)buttonClicked:(id)button
{
    //CCButton* bt = button;
    if ([purchaseRecords containsObject:@"士兵"]) {
        [[CCDirector sharedDirector]popScene];
    }else{
        [purchaseRecords addObject:@"士兵"];
        int inc = slider.sliderValue*maxNumber;
        int spend = -inc*price;
        
        GuoJia* guojia = [GuoJia sharedGuoJia];
        
        [guojia changeMoney:spend];
        [guojia changeSoldier:inc];
        CCLOG(@"%i",inc);
        [[CCDirector sharedDirector]popScene];
    }
}
-(void)update:(CCTime)delta
{
    //CCLOG(@"update %i",(int)slider.sliderValue*maxNumber);
    [purchaseNumber setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber)]];
    [requiredMoney setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber*price)]];
}

@end
