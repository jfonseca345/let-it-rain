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
                            [field.sprites removeObject:sprite];
                            
                            [cloud moveSprite:CGPointMake(cloud.position.x+(self.width/self.numberOfFieldsAxisX), cloud.position.y) ];
                            
                            
                            if (i+1<self.numberOfFieldsAxisX){
                                [self.fields[i+1][j] addSprite:cloud];
                                [self.fields[i+1][j] setChanged:YES];
                                cloud.fieldX++;
                            }
                            
                            
                        }else
                        if(field.wind < 0)
                        {
                            [field.sprites removeObject:sprite];
                            
                            [cloud moveSprite:CGPointMake(cloud.position.x-(self.width/self.numberOfFieldsAxisX), cloud.position.y) ];
                            
                            
                            if (i-1>self.numberOfFieldsAxisX){
                                [self.fields[i-1][j] addSprite:cloud];
                                [self.fields[i-1][j] setChanged:YES];
                                cloud.fieldX--;
                            }
                        }
                        
                        
                        if(cloud.pressure<field.pressure){
                            
                            [field.sprites removeObject:sprite];
                            
                            [cloud moveSprite:CGPointMake(cloud.position.x, cloud.position.y+(self.height/(2*self.numberOfFieldsAxisY))) ];
                            
                            if (j+1<self.numberOfFieldsAxisY){
                                [self.fields[i][j+1] addSprite:cloud];
                                [self.fields[i][j+1] setChanged:YES];
                                cloud.fieldY++;
                            }
                            
                        }
                        else if(cloud.pressure>field.pressure){
                            [field.sprites removeObject:sprite];
                            
                            [cloud moveSprite:CGPointMake(cloud.position.x, cloud.position.y-(self.height/(2*self.numberOfFieldsAxisY)))];
                            
                            if (j>0){
                                [self.fields[i][j-1] addSprite:cloud];
                                [self.fields[i][j-1] setChanged:YES];
                                cloud.fieldY--;
                            }
                            
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
            }
        }
    }
}

@end
