//
//  RSMap.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/30/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSMap.h"
#import "RSField.h"

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
            RSField * temporaryField = [[RSField alloc] initWithTemperature:0 Pressure:0 Wind:0];
            temporaryField.region = CGRectMake((CGFloat)i*self.width/x, (CGFloat)j*self.height/y, self.width/x, self.height/y);
            NSLog(@"%f, %f, %f, %f",(CGFloat)i*self.width/x, (CGFloat)j*self.height/y, self.width/x, self.height/y );
            [temporary addObject:temporaryField];
        }
        [self.fields addObject:temporary];
    }
    
}


-(RSField*) touchedField : (CGPoint) touch{
    int heightIndex = touch.y/(self.height/self.numberOfFieldsAxisY);
    int widthIndex = touch.x/(self.width/self.numberOfFieldsAxisX);
    
    return (RSField*)self.fields[widthIndex][heightIndex];
}

@end
