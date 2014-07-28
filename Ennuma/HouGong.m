//
//  HouGong.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "HouGong.h"
#import "IntroScene.h"
#import "RandomFeiZiGenerator.h"
#import "HuangDi.h"
@implementation HouGong
static HouGong* sharedHouGong;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //huanghou = [CCLabelTTF labelWithString:@"我是皇后" fontName:@"Verdana-Bold" fontSize:10];
    //huanghou.position = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
    //[self addChild:huanghou z:0 name:@"huanghou"];
    
    [self setUserInteractionEnabled:YES];
    stage = 1;
    return self;
}
+(CCScene*)sharedScene
{
    if (sharedHouGong) {
        //CCLOG(@"shared");
        [sharedHouGong refreshHouGong];
        return sharedHouGong;
    }
    sharedHouGong = [[self alloc] init];
    [sharedHouGong initData];
    [sharedHouGong refreshHouGong];
    [sharedHouGong initButton];
    return sharedHouGong;
}
-(void)initButton
{
    CCLabelTTF* leave = [CCLabelTTF labelWithString:@"离开" fontName:@"Verdana-Bold" fontSize:10];
    leave.position = CGPointMake(self.contentSize.width-leave.contentSize.width, leave.contentSize.height);
    [self addChild:leave z:0 name:@"离开"];
    
    CCLabelTTF* random = [CCLabelTTF labelWithString:@"随便翻个" fontName:@"Verdana-Bold" fontSize:10];
    random.position = CGPointMake(self.contentSize.width/2, random.contentSize.height);
    [self addChild:random z:0 name:@"随便翻个"];
    
    CCLabelTTF* gongnv = [CCLabelTTF labelWithString:@"安排宫女" fontName:@"Verdana-Bold" fontSize:10];
    gongnv.position = CGPointMake(self.contentSize.width/2, random.contentSize.height+20);
    [self addChild:gongnv z:0 name:@"安排宫女"];
    
    popup = [CCSprite spriteWithImageNamed:@"popup.png"];
    popup.position =CGPointMake(self.contentSize.width/2, self.contentSize.height/5*2);
    [self addChild:popup z:0 name:@"popup"];
    popup.visible = NO;

}
-(void)initData
{
    hougongDic = [[NSMutableDictionary alloc]init];
    
    FeiZi* feizi1 = [FeiZi node];
    feizi1.zhiwei = @"贵妃";
    FeiZi* feizi2 = [FeiZi node];
    feizi1.zhiwei = @"淑妃";
    FeiZi* feizi3 = [FeiZi node];
    feizi1.zhiwei = @"德妃";
    FeiZi* feizi4 = [FeiZi node];
    feizi1.zhiwei = @"贤妃";
    [hougongDic setObject:feizi1 forKey:@"贵妃"];
    [hougongDic setObject:feizi2 forKey:@"淑妃"];
    [hougongDic setObject:feizi3 forKey:@"德妃"];
    [hougongDic setObject:feizi4 forKey:@"贤妃"];
}
-(void)onEnter
{
    stage = 1;
}
-(void)refreshHouGong
{
    CCLOG(@"refresh");
    huanghou = [CCLabelTTF labelWithString:@"我是皇后" fontName:@"Verdana-Bold" fontSize:10];
    huanghou.position = CGPointMake(self.contentSize.width/2, self.contentSize.height-30);
    [self removeChildByName:@"皇后"];
    [self addChild:huanghou z:0 name:@"皇后"];
    
    CCLabelTTF* guifei = [CCLabelTTF labelWithString:((FeiZi*)[hougongDic objectForKey:@"贵妃"]).feiziname fontName:@"Verdana-Bold" fontSize:10];
    guifei.position = CGPointMake(self.contentSize.width/8, huanghou.position.y-50);
    [self removeChildByName:@"贵妃"];
    [self addChild:guifei z:0 name:@"贵妃"];
    
    CCLabelTTF* shufei = [CCLabelTTF labelWithString:((FeiZi*)[hougongDic objectForKey:@"淑妃"]).feiziname fontName:@"Verdana-Bold" fontSize:10];
    shufei.position = CGPointMake(self.contentSize.width/8*3, huanghou.position.y-50);
    [self removeChildByName:@"淑妃"];
    [self addChild:shufei z:0 name:@"淑妃"];
    
    CCLabelTTF* defei = [CCLabelTTF labelWithString:((FeiZi*)[hougongDic objectForKey:@"德妃"]).feiziname fontName:@"Verdana-Bold" fontSize:10];
    defei.position = CGPointMake(self.contentSize.width/8*5, huanghou.position.y-50);
    [self removeChildByName:@"德妃"];
    [self addChild:defei z:0 name:@"德妃"];
    
    CCLabelTTF* xianfei = [CCLabelTTF labelWithString:((FeiZi*)[hougongDic objectForKey:@"贤妃"]).feiziname fontName:@"Verdana-Bold" fontSize:10];
    xianfei.position = CGPointMake(self.contentSize.width/8*7, huanghou.position.y-50);
    [self removeChildByName:@"贤妃"];
    [self addChild:xianfei z:0 name:@"贤妃"];
    
    
}
-(void)showpopup
{
    popup.visible = YES;
}
-(void)hidepopup
{
    popup.visible = NO;
}
-(void)anpaigongnv
{
    RandomFeiZiGenerator* randomGen = [RandomFeiZiGenerator sharedRandomFeiZiGenerator];
    shiqin = [randomGen generateFeiZi];
    //message box pops up here
    //shiqin = [FeiZi node];
    [self shiqin];
    [self showpopup];
    newstage=2;
    //[hougongDic setObject:randomfeizi forKey:@"贵妃"];
    //CCLOG(((FeiZi*)[hougongDic objectForKey:@"贵妃"]).feiziname);
    //[[IntroScene sharedScene] passPhase];
    //[[CCDirector sharedDirector] popScene];
}
-(void)shiqin
{
    int inctili = shiqin.meili*3-88;
    inctili = MAX(10, inctili);
    [HuangDi sharedHuangDi].tili = MIN([HuangDi sharedHuangDi].maxtili,[HuangDi sharedHuangDi].tili+inctili);
    
    int inckuaile = 20;
    [HuangDi sharedHuangDi].kuaile = MIN([HuangDi sharedHuangDi].maxkuaile,[HuangDi sharedHuangDi].kuaile+inckuaile);
    
    
}
-(void)suibian
{
    //create an array and generate random index of that array to mimic the effect of suijishiqin
}
-(void)fengfeizi
{
    newstage= 3;
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{

    CGPoint touchpos = [touch locationInNode:self];
    CGRect box = huanghou.boundingBox;
    box.origin = [huanghou convertToWorldSpace:CGPointZero];
    if (stage==1) {
        for (CCNode* feizi in self.children) {
            CGRect boundingbox = feizi.boundingBox;
            boundingbox.origin = [feizi convertToWorldSpace:CGPointZero];
            if (CGRectContainsPoint(boundingbox, touchpos)) {
                if ([feizi.name isEqualToString:@"离开"]) {
                    [[CCDirector sharedDirector] popScene];
                }
                else if([feizi.name isEqualToString:@"随便翻个"])
                {
                    [self suibian];
                    CCLOG(@"suibian");
                }
                else if([feizi.name isEqualToString:@"安排宫女"])
                {
                    [self anpaigongnv];
                    CCLOG(@"anpai");
                }else{
                    FeiZi* m_feizi = [hougongDic objectForKey:feizi.name];
                    if([m_feizi.feiziname isEqualToString:@"无"]){
                        return;
                    }else{
                        shiqin = m_feizi;
                        [self shiqin];
                        [[IntroScene sharedScene] passPhase];
                        [[CCDirector sharedDirector] popScene];
                        
                        CCLOG(@"%@侍寝",m_feizi.feiziname);
                    }
                }
            }
        }
    }else if(stage==2){
        CGRect confirm = CGRectMake(182, 86, 262-182, 107-86);
        CGRect cancel = CGRectMake(301, 87, 386-301, 111-87);
        if (CGRectContainsPoint(cancel, touchpos)) {
            [self hidepopup];
            [[IntroScene sharedScene] passPhase];
            [[CCDirector sharedDirector] popScene];
        }
        if (CGRectContainsPoint(confirm, touchpos)) {
            [self hidepopup];
            [self fengfeizi];
        }
        CCLOG(@"%f,%f",touchpos.x,touchpos.y);
    }else if(stage==3)
    {
        for (CCNode* feizi in self.children) {
            CGRect boundingbox = feizi.boundingBox;
            boundingbox.origin = [feizi convertToWorldSpace:CGPointZero];
            if (CGRectContainsPoint(boundingbox, touchpos)) {
                if ([feizi.name isEqualToString:@"离开"]) {
                    [[IntroScene sharedScene] passPhase];
                    [[CCDirector sharedDirector] popScene];
                }
                else
                {
                    FeiZi* m_feizi = [hougongDic objectForKey:feizi.name];
                    //CCLOG(feizi.name);
                    if ([m_feizi.feiziname isEqualToString:@"无"]) {
                        [hougongDic setObject:shiqin forKey:feizi.name];
                        //do somthing here
                        //[self refreshHouGong];
                    }
                    else{
                        return;
                    }
                }
            }
        }
        [self refreshHouGong];
    }
    stage = newstage;
    return;
    //if (CGRectContainsPoint(box, touchpos)) {
    //    [[IntroScene sharedScene] passPhase];
    //    [[CCDirector sharedDirector] popScene];
    //}
}

@end
