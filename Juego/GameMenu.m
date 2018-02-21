//
//  GameMenu.m
//  Juego
//
//  Created by ALUMNO on 17/2/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import "GameMenu.h"
#import "GameViewController.h"
#import "GameScene.h"
#import "GameData.h"

@implementation GameMenu

- (void)sceneDidLoad {
    //Referenciamos el botón del mensaje
    _message = (SKLabelNode*) [self childNodeWithName:@"Message"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *touchedNode = [self nodeAtPoint:location];
    
    if ([touchedNode.name isEqualToString:@"nuevaPartida"]) {
        GKScene *scene = [GKScene sceneWithFileNamed:@"GameScene"];
        GameScene *sceneNode = (GameScene *)scene.rootNode;
        sceneNode.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        sceneNode.monedas = 0;
        sceneNode.vida = 60;
        
        skView.showsFPS = true;
        
        [skView presentScene:sceneNode];
    }
    
    if ([touchedNode.name isEqualToString:@"cargarPartida"] && [GameData obtenerEscena] != nil){
        GKScene *scene = [GKScene sceneWithFileNamed:[GameData obtenerEscena]];
        GameScene *sceneNode = (GameScene *)scene.rootNode;
        sceneNode.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        sceneNode.monedas = [GameData obtenerMonedas];
        sceneNode.vida =  [GameData obtenerVida];
        
        NSLog(@"%@", [NSString stringWithFormat:@"%ld , %ld" , [GameData obtenerMonedas] , [GameData obtenerVida]]);
        
        skView.showsFPS = true;
        
        [skView presentScene:sceneNode];
    } else if ([GameData obtenerEscena] != nil) { //Si no hay escena guardada que muestre la info
        _message.text = @"NO HAY PARTIDAAAAAAA";
    }
}

@end
