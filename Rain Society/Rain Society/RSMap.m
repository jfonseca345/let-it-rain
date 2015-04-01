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

@implementation RSMap

-(id) initWithWidth: (int) width Height: (int) height{
    self=[super init];
    self.width=width;
    self.height=height;
    self.numberOfFieldsAxisX=1;
    self.numberOfFieldsAxisY=1;
    
    self.actionQueue = [[NSMutableArray alloc]init];
    
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
                        else if (field.wind<0)
                            //Andemos para a esquerda
                        {
                            if (!(field.cloudControl)){
                                [field setCloudControl:YES];
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
                        
                        if (field.temperature<-2) {
                            [cloud emitParticleNamed:@"RainParticle"];
                            
                        }
                        else{
                            [cloud stopEmiting];
                        }
                        
                    }
                    
                    
                    if ([sprite.name isEqualToString:@"lago"]){
                        NSLog(@"UpdateLago");
                        ELake* lake = (ELake*) sprite;
                        
                        if(field.temperature>=3){
                            lake.spawnCloud=YES;
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
