//
//  RSMap.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/30/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSMap.h"
#import "RSField.h"
#import "ECloud.h"
#import "ELake.h"
#import "RSSound.h"
#import "RSAudioPlayer.h"

@implementation RSMap

-(id) initWithWidth: (int) width Height: (int) height{
    self=[super init];
    self.width=width;
    self.height=height;
    self.numberOfFieldsAxisX=1;
    self.numberOfFieldsAxisY=1;
    self.isCloud = NO;
    
    self.audioPlayer = [[RSAudioPlayer alloc]init];
    [self loadSounds];
    
    
    return self;
}

-(void) createFields: (int) x and: (int) y{
    self.numberOfFieldsAxisX=x;
    self.numberOfFieldsAxisY=y;
    //self.fields = [[NSMutableArray alloc]initWithCapacity:x];
    self.fields= [NSMutableArray array];
    for(int i=0; i<x;i++){
        NSMutableArray *temporary = [NSMutableArray array];
        for(int j=0; j<y; j++){
            RSField * temporaryField = [[RSField alloc] initWithTemperature:0 Pressure:((y-j)*25) Wind:0];
            temporaryField.region = CGRectMake((CGFloat)i*self.width/x, (CGFloat)j*self.height/y, self.width/x, self.height/y);
            [temporary addObject:temporaryField];
        }
        [self.fields addObject:temporary];
    }
    
}

- (void) loadSounds
{
    RSSound *music = [[RSSound alloc]init];
    music.tipo = BGM;
    music.nomeDoSom = @"Fundo";
    music.nomeDoArquivo = @"Easy Lemon";
    music.extensaoDoArquivo = @"mp3";
    
    RSSound *rainFX = [[RSSound alloc]init];
    rainFX.tipo = SFX;
    rainFX.nomeDoSom = @"rainFX";
    rainFX.nomeDoArquivo = @"rainSound";
    rainFX.extensaoDoArquivo = @"mp3";
    [self.audioPlayer.SoundArray addObject: music];
    [self.audioPlayer.SoundArray addObject: rainFX];
    
    
}


-(RSField*) touchedField : (CGPoint) touch{
    int heightIndex = (touch.y*self.numberOfFieldsAxisY)/(self.height);
    int widthIndex = (touch.x*self.numberOfFieldsAxisX)/(self.width);
    
    return (RSField*)self.fields[widthIndex][heightIndex];
}

-(void) addSprite : (RSSprite*)sprite inField:(int) fieldx and:(int) fieldy{
    
    [self.fields[fieldx][fieldy] addSprite:sprite];
    sprite.fieldX = fieldx;
    sprite.fieldY = fieldy;
    sprite.mapParent = self;
}

-(void)updateFields{
    //Territorio da montanha
    CGPoint unpassableTerrain = CGPointMake(1, 0);
    
    for (int i=0;i<self.numberOfFieldsAxisX;i++){
        for (int j=0;j<self.numberOfFieldsAxisY;j++){
            //Actual field
            RSField* field = self.fields[i][j];
            //if variable of field has changed
            if (field.changed){
                NSLog(@"Update(%d,%d)",i,j);
                for(RSSprite* sprite in field.sprites){
                    NSLog(@"Update:%@", sprite.name);
                    if ([sprite.name isEqualToString:@"nuvem"]){
                        NSLog(@"UpdateNuvem");
                        ECloud* cloud = (ECloud*) sprite;
                            
                        //Rotinas de vento
                        if(field.wind > 0)
                        {
                            //Devemos checar o vento do seu vizinho direito
                            //Andemos para a direita
                            if (!(field.cloudControl)){
                                [field setCloudControl:YES];
                                
                                if(((i+1)==unpassableTerrain.x) && (j==unpassableTerrain.y))
                                {
                                    SKAction* action = [SKAction moveByX:(field.region.size.width)/2 y:0 duration:1.0];
                                    [cloud runAction:action completion:^{
                                        SKAction* backAction = [SKAction moveByX:-(field.region.size.width)/2 y:0 duration:1.0];
                                        [cloud runAction:backAction];
                                        field.changed = YES;
                                        [field setCloudControl:NO];
                                    }];
                                    
                                }else
                                    
                                {
                                    SKAction* action = [SKAction moveByX:field.region.size.width y:0 duration:1.0];
                                    [cloud runAction:action completion:^{
                                        [field.sprites removeObject:sprite];
                                        if (i+1<self.numberOfFieldsAxisX){
                                            [self.fields[i+1][j] addSprite:cloud];
                                            [self.fields[i+1][j] setChanged:YES];
                                            cloud.fieldX++;
                                            [field setCloudControl:NO];
                                        }
                                    }];
                                }
                            }
                        }
                        else if (field.wind<0)
                            //Andemos para a esquerda
                        {
                            if (!(field.cloudControl)){
                                [field setCloudControl:YES];
                                //Adentramos a montanha
                                if(((i-1)==unpassableTerrain.x) && (j==unpassableTerrain.y))
                                {
                                    SKAction* action = [SKAction moveByX:-(field.region.size.width)/1.2 y:0 duration:1.0];
                                    [cloud runAction:action completion:^{
                                        SKAction* backAction = [SKAction moveByX:(field.region.size.width)/1.2 y:0 duration:1.0];
                                        [cloud runAction:backAction];
                                        field.changed = YES;
                                        [field setCloudControl:NO];
                                    }];
                                    
                                }else
                                {
                                    SKAction* action = [SKAction moveByX:-(field.region.size.width) y:0 duration:1.0];
                                    [cloud runAction:action completion:^{
                                        [field.sprites removeObject:sprite];
                                        if (i-1>=0){
                                            [self.fields[i-1][j] addSprite:cloud];
                                            [self.fields[i-1][j] setChanged:YES];
                                            cloud.fieldX--;
                                            [field setCloudControl:NO];
                                        }
                                    }];
                                }
                            }
                            
                        }
                        
                        if(cloud.pressure<field.pressure){
                            
                            SKAction* action = [SKAction moveByX:0 y:(field.region.size.height/2) duration:1.0];
                            [cloud runAction:action completion:^{
                                [field.sprites removeObject:sprite];
                                if (j+1<self.numberOfFieldsAxisY){
                                    [self.fields[i][j+1] addSprite:cloud];
                                    [self.fields[i][j+1] setChanged:YES];
                                    cloud.fieldY++;
                                }
                            }];
                            
                        }
                        else if(cloud.pressure>field.pressure){
                            if(((i)==unpassableTerrain.x) && ((j-1)==unpassableTerrain.y))
                            {
                                SKAction* action = [SKAction moveByX:0 y:-(field.region.size.height/3) duration:0.7];
                                [cloud runAction:action completion:^{
                                    SKAction* backAction = [SKAction moveByX:0 y:(field.region.size.height/3) duration:0.7];
                                    [cloud runAction:backAction];
                                }];
                            }else{
                                SKAction* action = [SKAction moveByX:0 y:-(field.region.size.height/2) duration:1.0];
                                [cloud runAction:action completion:^{
                                    [field.sprites removeObject:sprite];
                                    if (j-1>=0){
                                        [self.fields[i][j-1] addSprite:cloud];
                                        [self.fields[i][j-1] setChanged:YES];
                                        cloud.fieldY--;
                                    }
                                }];
                            }
                        }
                        
                        if (field.temperature<-2) {
                            [cloud emitParticleNamed:@"RainParticle"];
                            [self.audioPlayer tocaSom:@"rainSound" comVolume:0.1];
                            if(cloud.fieldX == (self.numberOfFieldsAxisX-1) && cloud.fieldY==0)
                            {
                                SKLabelNode *victoryLabel = [SKLabelNode labelNodeWithText:@"Sucesso!"];
                                victoryLabel.fontName=@"Chalkduster";
                                victoryLabel.fontSize=100;
                                victoryLabel.position=CGPointMake(CGRectGetMidX(self.scene.frame),CGRectGetMidY(self.scene.frame));
                                [self.scene addChild:victoryLabel];
                                SKAction *fadeOut = [SKAction fadeOutWithDuration:3];
                                [cloud runAction: fadeOut completion:^{
                                    [self.audioPlayer stopSFX:YES];
                                    [cloud removeFromParent];
                                    cloud.fieldX = 0;
                                    cloud.fieldY = 0;
                        
                                }];
                                
                            }
                        }
                        else{
                            [cloud stopEmiting];
                            [self.audioPlayer stopSFX:YES];
                        }
                        
                    }
                    
                    
                    if ([sprite.name isEqualToString:@"lago"]){
                        NSLog(@"UpdateLago");
                        ELake* lake = (ELake*) sprite;
                        
                        if(field.temperature>=3){
                            if(self.isCloud == NO)
                            {
                                lake.spawnCloud=YES;
                                self.isCloud = YES;
                            }else
                                lake.spawnCloud = NO;
                        }
                        else{
                            lake.spawnCloud=NO;
                        }
                    }
                    
                }
                field.changed = NO;
            }
        }
    }
}

@end
