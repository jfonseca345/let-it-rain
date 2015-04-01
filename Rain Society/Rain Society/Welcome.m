//
//  Welcome.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 4/1/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "Welcome.h"
#import "RSButton.h"
#import "GameViewController.h"
#import "GameScene.h"
@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end


@implementation Welcome


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKView * skView = (SKView *)self.view;
    /*Configura Plano de Fundo*/
    self.backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"Let it rain header"];
    [self.backgroundImage setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self.backgroundImage setSize:CGSizeMake(self.size.width,self.size.height)];
    [self addChild:self.backgroundImage];
    
    /*Configura botão de inicio*/

    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    RSButton* startButton = [[RSButton alloc] initWithText:@"Começar"];
    [startButton setZPosition:200];
    [startButton setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
    [startButton setHandler:^{
        [skView presentScene:scene];
    }];
    [self addChild:startButton];
    
    

    
}

@end
