//
//  GameScene.h
//  Juego
//
//  Created by alumno on 24/1/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
 

@property (nonatomic) SKSpriteNode* personaje;
@property (nonatomic) SKSpriteNode* personajeLiche;
@property (nonatomic) SKSpriteNode* monstruo1;
@property (nonatomic) SKSpriteNode* monstruo2;
@property (nonatomic) SKSpriteNode* monstruo3;

//Cosas de la tienda:
@property (nonatomic) SKSpriteNode* tienda; //La tienda
@property (nonatomic) SKSpriteNode* entrarTienda; //Botón de dólar para comprar
@property (nonatomic) SKSpriteNode* menuTienda; //La propia tienda
@property (nonatomic) SKAudioNode* audioTienda; //Audios para abrir y cerrar la tienda
//

@property (nonatomic) SKSpriteNode* guardarYSalir;

@property (nonatomic) SKSpriteNode* corazon1;
@property (nonatomic) SKSpriteNode* corazon2;
@property (nonatomic) SKSpriteNode* corazon3;

@property (nonatomic) SKCameraNode* camara;  

@property (nonatomic) UILabel* labelMonedas;

@property (nonatomic) bool esNuevaPartida;

@property (nonatomic) long monedas;
@property  (nonatomic) long vida;

 




- (void)transformacion;
- (void)sigueAlJugador:(SKSpriteNode*)objeto;
- (void)addMonster ;
- (void)pausaElJuego;
- (void)muevete:(CGPoint)touchedPoint ;
- (void)parar;
- (void)camaraSigueme;
- (void)compruebaVida;
- (void)morir;
- (void)estarQuieto;
- (void)atacar;
- (void)saltar;
- (void)correr;
- (void)inicializaLosBooleanos;
- (void)creaLasColisiones;
- (void)cargarTodasLasAnimaciones;
- (void)enganchaReferenciasDeAquiConLasDeLaEscena;


@end
