//
//  InGameMenuLayer.m
//  CircleGame
//
//  Created by Joanne Dyer on 1/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "InGameMenuLayer.h"

@interface InGameMenuLayer ()

@property (nonatomic, strong) GameLayer *gameLayer;

@end

@implementation InGameMenuLayer

@synthesize gameLayer = _gameLayer;

- (id)initWithGameLayer:(GameLayer *)gameLayer resumeAvailable:(BOOL)resumeAvailable
{
	if( (self=[super init]) ) {
        self.gameLayer = gameLayer;
        
        // ask director for the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            background = [CCSprite spriteWithFile:@"InGameMenuBackground.png"];
            //background.rotation = 90;
        } else {
            background = [CCSprite spriteWithFile:@"InGameMenuBackground.png"];
        }
        background.position = ccp(size.width/2, size.height/2);
        
        // add the background as a child to this Layer
        [self addChild: background z:0];
        
        //Create the Resume Menu Item.
        CCMenuItemImage *resumeMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"ResumeButton.png" selectedImage:@"ResumeButtonSelected.png"
                                    target:self selector:@selector(resumeButtonTapped:)];
        resumeMenuItem.anchorPoint = ccp(0, 1);
        resumeMenuItem.position = ccp(49, 404);
        
        //Create the Restart Menu Item.
        CCMenuItemImage *restartMenuItem = [CCMenuItemImage
                                      itemWithNormalImage:@"RestartButton.png" selectedImage:@"RestartButtonSelected.png"
                                      target:self selector:@selector(restartButtonTapped:)];
        restartMenuItem.anchorPoint = ccp(0, 1);
        
        //Change the position based on whether resume is available.
        if (resumeAvailable) {
            restartMenuItem.position = ccp(140, 333);
        } else {
            restartMenuItem.position = ccp(100, 370);
        }
        
        //Create the 'Main Menu' Menu Item.
        CCMenuItem *mainMenuMenuItem = [CCMenuItemImage
                                       itemWithNormalImage:@"MenuButton.png" selectedImage:@"MenuButtonSelected.png"
                                       target:self selector:@selector(mainMenuButtonTapped:)];
        mainMenuMenuItem.anchorPoint = ccp(0, 1);
        
        //Change the position based on whether resume is available.
        if (resumeAvailable) {
            mainMenuMenuItem.position = ccp(45, 197);
        } else {
            mainMenuMenuItem.position = ccp(55, 210);
        }

        //Only add resumeMenuItem if resume is available.
        CCMenu *inGameMenu;
        if (resumeAvailable) {
            inGameMenu = [CCMenu menuWithItems:resumeMenuItem, restartMenuItem, mainMenuMenuItem, nil];
        } else {
            inGameMenu = [CCMenu menuWithItems:restartMenuItem, mainMenuMenuItem, nil];            
        }
        inGameMenu.position = CGPointZero;
        [self addChild:inGameMenu];
        
        self.isTouchEnabled = YES;
	}
	return self;
}

//prevent touches going to over layers.
- (void)registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)resumeButtonTapped:(id)sender
{
    [self.gameLayer unPauseGame];
    [self removeFromParentAndCleanup:YES];
}

- (void)restartButtonTapped:(id)sender
{
    [self.gameLayer restartGame];
    [self removeFromParentAndCleanup:YES];
}

- (void)mainMenuButtonTapped:(id)sender
{
    
}

@end
