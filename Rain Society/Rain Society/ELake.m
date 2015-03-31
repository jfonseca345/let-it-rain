//
//  ELake.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "ELake.h"
#import "RSButton.h"

@implementation ELake

-(id) initWithPosition: (CGPoint) position{
    self = [super initWithImageNamed:@"lago"];
    self.zPosition = 2;
    [self setPosition:position];
    [self setUserInteractionEnabled:YES];
    [self.physicsBody setDynamic:NO];
    [self setSpawnCloud:NO];
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.spawnCloud){
        NSLog(@"Nuvem");
        RSButton* spawnCloudButton = [[RSButton alloc] initWithText:@" Criar Nuvem! "];
        [spawnCloudButton setColor:[UIColor redColor]];
        [spawnCloudButton setPosition:CGPointMake(100, 200)];
        [spawnCloudButton setColor:[UIColor redColor]];
        [spawnCloudButton setHandler:^{
        NSArray* childrenScene = [self.parent children];
        RSButton* popup;
        
        for (SKNode* node in childrenScene){
            if ([node.name isEqualToString:@" Criar Nuvem! "]){
                RSMap* mapFather = (RSMap*)self.mapParent;
                popup=(RSButton*)node;
                ECloud* cloud = [[ECloud alloc] initWithPosition:self.frame.origin];
                cloud.pressure = 50;
                 [cloud fadeOut];
                [cloud moveSprite:CGPointMake(cloud.position.x+60, mapFather.height/(mapFather.numberOfFieldsAxisY))];
                [cloud fadeIn];
                [mapFather addSprite:cloud inField:0 and:0];
                [self.parent addChild:cloud];
                
            }
            
        }
        
        [popup removeFromParent];
    }];
    
    [self.parent addChild:spawnCloudButton];
    }
}
@end
