


//
//  HUDLayer.m
//  GeneCar
//
//  Created by Andrea Terzani on 02/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "SynthesizeSingleton.h"
#import "GameManager.h"
#import "TestScene.h"
#import "GarageScene.h"
#import "Garage.h"
#import "MenuLayer.h"

@implementation HUDLayer
SYNTHESIZE_SINGLETON_FOR_CLASS(HUDLayer);
@synthesize score,avgFitness,generation,lastScore;

- (id)init
{
    self = [super init];
    if (self) {
        
        scoreLabel=[CCLabelTTF labelWithString:@"Score : 0" fontName:@"Marker Felt" fontSize:15];
        scoreLabel.position=ccp(200,20);
        [self addChild:scoreLabel];
    
        avgLabel=[CCLabelTTF labelWithString:@"Avg : 0" fontName:@"Marker Felt" fontSize:15];
        avgLabel.position=ccp(50,20);
        [self addChild:avgLabel];
        
        generLabel=[CCLabelTTF labelWithString:@"Gen. : 0" fontName:@"Marker Felt" fontSize:15];
        generLabel.position=ccp(290,20);
        [self addChild:generLabel];
        
        lastScoreLabel=[CCLabelTTF labelWithString:@"Last Scr : 0" fontName:@"Marker Felt" fontSize:15];
        lastScoreLabel.position=ccp(320,250);
        [self addChild:lastScoreLabel];
        
         score=avgFitness=generation=lastScore=0;
        
        
        list_elem=0;
        
        list_y=290;
        list_x=25;
        
        
        
        CCMenuItemFont *menuItem1 = [CCMenuItemFont itemFromString:@"Exit" target:self selector:@selector(onExit:)];
		
		[menuItem1 setColor: ccc3(255,255,255)];
		[menuItem1 setScale:1.0];
		menuItem1.position=ccp(400,100);
        
        CCMenuItemFont *menuItem2 = [CCMenuItemFont itemFromString:@"Save" target:self selector:@selector(onSave:)];
		
		[menuItem2 setColor: ccc3(255,255,255)];
		[menuItem2 setScale:1.0];
		menuItem2.position=ccp(400,50);
		
        
        CCMenuItemFont *menuItem3 = [CCMenuItemFont itemFromString:@"Save Best" target:self selector:@selector(onSaveBest:)];
		
		[menuItem3 setColor: ccc3(255,255,255)];
		[menuItem3 setScale:1.0];
		menuItem3.position=ccp(400,150);
        
        
		CCMenu *menu = [CCMenu menuWithItems:menuItem1,menuItem2,menuItem3 ,nil];
        menu.position=ccp(0,0);
        
        [self addChild:menu];
        
    }
    
    return self;
}

- (void)onSave:(id)sender
{
    GameManager *GM= [GameManager sharedGameManager];
    
    [GM setCachedCromo:[GM currentCromo]];
    
    [GM setGarageSaveMode:TRUE];
    
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GarageScene scene]]];
}

- (void)onSaveBest:(id)sender
{
    GameManager *GM= [GameManager sharedGameManager];
    
    [GM setCachedCromo:[GM bestEver]];
    [GM setCurrentCromo:[GM bestEver]];
    
    
    [GM setGarageSaveMode:TRUE];
    
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GarageScene scene]]];
}


- (void)onExit:(id)sender
{
    GameManager *GM= [GameManager sharedGameManager];
    
    [GM setCachedCromo:[GM currentCromo]];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[MenuLayer scene]]];
}

-(void) draw
{
    [scoreLabel setString:[NSString stringWithFormat:@"Score : %0.02f",score]];
    [avgLabel setString:[NSString stringWithFormat:@"Avg : %0.02f",avgFitness]];
    [generLabel setString:[NSString stringWithFormat:@"Gen. : %d",generation]];
    [lastScoreLabel setString:[NSString stringWithFormat:@"Last Scr : %f",lastScore]];

}

- (void)addListScore:(float) list_score{
    
    if(list_elem<20){
        list_elem++;
        list_y-=13;
        CCLabelTTF * CL = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d. %0.02f",list_elem,list_score] fontName:@"Marker Felt" fontSize:10];
        CL.position=ccp(list_x,list_y);
    
        [self addChild:CL];
            [list_label addObject:CL];
    }else{
        
        for(CCLabelTTF *C in list_label){
            [C setString:@"      Porcoooooo"];
                        
        }
        list_elem=0;
        list_y=290;
        list_x+=50;
        [list_label removeAllObjects];
        [self addListScore:list_score];
    
    }
}


@end
