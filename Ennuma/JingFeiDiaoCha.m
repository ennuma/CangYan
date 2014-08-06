//
//  JingFeiDiaoCha.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-6.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "JingFeiDiaoCha.h"
#import "GuoJia.h"
@implementation JingFeiDiaoCha
static JingFeiDiaoCha* sharedScene;
+(JingFeiDiaoCha*)sharedJingfei
{
    if (sharedScene) {
        return sharedScene;
    }
    
    sharedScene = [JingFeiDiaoCha node];
    return sharedScene;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self initLayout];
    
    return self;
}



-(void)onEnter
{
    [self resetAdjustRequest];
    maxNumber = [[GuoJia sharedGuoJia]getGuoKu];
    [super onEnter];
}

-(void)resetAdjustRequest
{
    //[adjustRecords removeAllObjects];
    slider.sliderValue = 0;
}
-(void)initLayout
{
    slider =  [CCSlider node];
    slider = [slider initWithBackground:[CCSpriteFrame frameWithImageNamed:@"hud.png"] andHandleImage:[CCSpriteFrame frameWithImageNamed:@"Player.png"] ];
    [self addChild:slider];
    slider.position = ccp(self.contentSize.width/2-slider.contentSize.width/2,self.contentSize.height/2);
    
    CCButton* confirm = [CCButton buttonWithTitle:@"确定经费调查"];
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
    int result = slider.sliderValue*maxNumber;
        
    GuoJia* guojia = [GuoJia sharedGuoJia];
        
    [guojia spendMoney:result];
    CCLOG(@"%i",result);
    [[CCDirector sharedDirector]popScene];
}
-(void)update:(CCTime)delta
{
    //CCLOG(@"update %i",(int)slider.sliderValue*maxNumber);
    [purchaseNumber setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber)]];
    //[requiredMoney setString:[NSString stringWithFormat:@"%i",(int)(slider.sliderValue*maxNumber*price)]];
}


@end
