//
//  GameScene.m
//  Juego
//
//  Created by alumno on 24/1/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import "GameScene.h"
#import "GameData.h"

@implementation GameScene

    SKAction* mover;
    float velocidadMovimientoPersonajeCaballero = 2.0f;

    SKAction* saltar;
    SKAction* seguir;
    SKAction* muerteMonstruo;
    
    CGFloat personajePosX;
    CGFloat personajePosY;

    //ANIMACIONES SHOVEL KNIGHT

    //Movimiento
    SKTextureAtlas *animacionesMoverseAtlas;
    NSMutableArray *animacionesMoverseFrames;
    //Ataque
    SKTextureAtlas *animacionesAtacarKnight1Atlas;
    NSMutableArray *animacionesAtacarKnight1Frames;
    //Saltar
    SKTextureAtlas *animacionesSaltarKnight1Atlas;
    NSMutableArray *animacionesSaltarKnight1Frames;
    //Idle
    SKTextureAtlas *animacionesIdleKnight1Atlas;
    NSMutableArray *animacionesIdleKnight1Frames;
    //Idle 2
    SKTextureAtlas *animacionesIdleKnight2Atlas;
    NSMutableArray *animacionesIdleKnight2Frames;
    //Idle 3
    SKTextureAtlas *animacionesIdleKnight3Atlas;
    NSMutableArray *animacionesIdleKnight3Frames;
    //Transformacion
    SKTextureAtlas *animacionesTransformacion1Atlas;
    NSMutableArray *animacionesTransformacion1Frames;
    //Muerte
    SKTextureAtlas *animacionesMuerteGuerreroAtlas;
    NSMutableArray *animacionesMuerteGuerreroFrames;

    //ANIMACIONES LICHE

    //Correr
    SKTextureAtlas *animacionesCorrerLicheAtlas;
    NSMutableArray *animacionesCorrerLicheFrames;
    //Transformacion completada
    SKTextureAtlas *animacionesTransformacionLicheAtlas;
    NSMutableArray *animacionesTransformacionLicheFrames;
    //Idle
    SKTextureAtlas *animacionesIdleLicheAtlas;
    NSMutableArray *animacionesIdleLicheFrames;
    //Atacar
    SKTextureAtlas *animacionesAtackLicheAtlas;
    NSMutableArray *animacionesAtacarLicheFrames;

    bool estoyApretando;
    bool estoyAtacando;
    bool estoySaltando;
    bool estoyQuieto;
    bool estoyTransformado;
    bool estoyVivo;

    int precioObjeto = 0;

    //Para el tema de las colisiones
    int personajeCategoria = 1;
    int mundoCategoria = 2;
    int monstruoCategoria = 3;
    int tiendaCategoria = 5;

    CGFloat orientacionDelPersonaje=1;
    CGFloat orientacionDelMonstruo=1;

- (void)sceneDidLoad {
    
    NSLog(@"%@", self.scene.name);
    
    [self enganchaReferenciasDeAquiConLasDeLaEscena];
    [self creaLasColisiones];
    [self inicializaLosBooleanos];
    [self cargarTodasLasAnimaciones];
    [self addMonster];
    
    //Sonará de fondo la música
    //[self runAction:[SKAction playSoundFileNamed:@"Night-in-the-forest.wav" waitForCompletion:NO]];
}


-(void)enganchaReferenciasDeAquiConLasDeLaEscena{
    //El personaje
    _personaje = (SKSpriteNode*) [self childNodeWithName:@"personaje"];
    //Corazones de vida
    _corazon1 = (SKSpriteNode*) [self childNodeWithName:@"//corazon1"];
    _corazon2 = (SKSpriteNode*) [self childNodeWithName:@"//corazon2"];
    _corazon3 = (SKSpriteNode*) [self childNodeWithName:@"//corazon3"];
    //Cosas de la tienda
    _tienda = (SKSpriteNode*) [self childNodeWithName:@"Tienda"]; //La tienda
    _entrarTienda = (SKSpriteNode*) [self childNodeWithName:@"//EntrarTienda"]; //Botón para entrar a la tienda
    _menuTienda = (SKSpriteNode*) [self childNodeWithName:@"//MenuTienda"]; //El menu de la propia tienda
    //Guardar y salir
    _guardarYSalir = (SKSpriteNode*) [self childNodeWithName:@"//GuardarYSalir"];
    _guardarYSalir.hidden = true;
    //Cámara
    _camara = (SKCameraNode*) [self childNodeWithName:@"camara"];
    //Monedas
    _labelMonedas = (UILabel*) [self childNodeWithName:@"//monedas"];
}

-(void)cargarTodasLasAnimaciones{
    
    //SHOVEL KNIGHT
    
    //Moverse
    animacionesMoverseFrames = [NSMutableArray array];
    animacionesMoverseAtlas = [SKTextureAtlas atlasNamed:@"animations"];
    
    long numImages = animacionesMoverseAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesMoverseAtlas textureNamed:textureName];
        [animacionesMoverseFrames addObject:temp];
    }
    
    //Atacar
    animacionesAtacarKnight1Frames = [NSMutableArray array];
    animacionesAtacarKnight1Atlas = [SKTextureAtlas atlasNamed:@"animationsAtackKnight"];
    
    numImages = animacionesAtacarKnight1Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesAtacarKnight1Atlas textureNamed:textureName];
        [animacionesAtacarKnight1Frames addObject:temp];
    }
    
    //Saltar
    animacionesSaltarKnight1Frames = [NSMutableArray array];
    animacionesSaltarKnight1Atlas = [SKTextureAtlas atlasNamed:@"animationsJumpKnight"];
    
    numImages = animacionesSaltarKnight1Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesSaltarKnight1Atlas textureNamed:textureName];
        [animacionesSaltarKnight1Frames addObject:temp];
    }
    
    //Idle 1
    animacionesIdleKnight1Frames = [NSMutableArray array];
    animacionesIdleKnight1Atlas = [SKTextureAtlas atlasNamed:@"animationsIdleKnight"];
    
    numImages = animacionesIdleKnight1Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesIdleKnight1Atlas textureNamed:textureName];
        [animacionesIdleKnight1Frames addObject:temp];
    }
    
    //Idle 2
    animacionesIdleKnight2Frames = [NSMutableArray array];
    animacionesIdleKnight2Atlas = [SKTextureAtlas atlasNamed:@"animationsCampfire"];
    
    numImages = animacionesIdleKnight2Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesIdleKnight2Atlas textureNamed:textureName];
        [animacionesIdleKnight2Frames addObject:temp];
    }
    
    //Idle 3
    animacionesIdleKnight3Frames = [NSMutableArray array];
    animacionesIdleKnight3Atlas = [SKTextureAtlas atlasNamed:@"animationsFishing"];
    
    numImages = animacionesIdleKnight3Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesIdleKnight3Atlas textureNamed:textureName];
        [animacionesIdleKnight3Frames addObject:temp];
    }
    
    //Transformacion
    animacionesTransformacion1Frames = [NSMutableArray array];
    animacionesTransformacion1Atlas = [SKTextureAtlas atlasNamed:@"animationsKnightTransformation"];
    
    numImages = animacionesTransformacion1Atlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesTransformacion1Atlas textureNamed:textureName];
        [animacionesTransformacion1Frames addObject:temp];
    }
    
    //Muertes
    animacionesMuerteGuerreroFrames = [NSMutableArray array];
    animacionesMuerteGuerreroAtlas = [SKTextureAtlas atlasNamed:@"animationsDeadKnight"];
    
    numImages = animacionesMuerteGuerreroAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesMuerteGuerreroAtlas textureNamed:textureName];
        [animacionesMuerteGuerreroFrames addObject:temp];
    }
    
    //LICHE
    
    //Correr
    animacionesCorrerLicheFrames = [NSMutableArray array];
    animacionesCorrerLicheAtlas = [SKTextureAtlas atlasNamed:@"animationsLichRun"];
    
    numImages = animacionesCorrerLicheAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesCorrerLicheAtlas textureNamed:textureName];
        [animacionesCorrerLicheFrames addObject:temp];
    }
    
    //Transformacion completada
    animacionesTransformacionLicheFrames = [NSMutableArray array];
    animacionesTransformacionLicheAtlas = [SKTextureAtlas atlasNamed:@"animationsLichTransformation"];
    
    numImages = animacionesTransformacionLicheAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesTransformacionLicheAtlas textureNamed:textureName];
        [animacionesTransformacionLicheFrames addObject:temp];
    }
    
    //Idle
    animacionesIdleLicheFrames = [NSMutableArray array];
    animacionesIdleLicheAtlas = [SKTextureAtlas atlasNamed:@"animationsLichIdle"];
    
    numImages = animacionesIdleLicheAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesIdleLicheAtlas textureNamed:textureName];
        [animacionesIdleLicheFrames addObject:temp];
    }
    
    //Atacar
    animacionesAtacarLicheFrames = [NSMutableArray array];
    animacionesAtackLicheAtlas = [SKTextureAtlas atlasNamed:@"animationsLichAtack"];
    
    numImages = animacionesAtackLicheAtlas.textureNames.count;
    for (int i = 0; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [animacionesAtackLicheAtlas textureNamed:textureName];
        [animacionesAtacarLicheFrames addObject:temp];
    }
}

-(void)creaLasColisiones{
    
    self.physicsWorld.contactDelegate = self;
    
    //Las colisiones de nuestro personaje
    _personaje.physicsBody.categoryBitMask = personajeCategoria;
    _personaje.physicsBody.contactTestBitMask = personajeCategoria | mundoCategoria;
    _personaje.physicsBody.collisionBitMask = mundoCategoria;
    
    //Las colisiones que posee la tienda
    _tienda.physicsBody.categoryBitMask = tiendaCategoria;
    _tienda.physicsBody.contactTestBitMask = personajeCategoria | mundoCategoria;
    _tienda.physicsBody.collisionBitMask = mundoCategoria;
}

-(void)inicializaLosBooleanos{
    estoyApretando = false; //No nos hemos movido
    estoyAtacando = false; //No hemos atacado
    estoySaltando = false; //No hemos saltado
    estoyQuieto = true; //Estamos quietos
    estoyTransformado = false; //No empezamos transformados
    estoyVivo = true; //Empezamos vivos
}

-(void)correr{
    if(estoyTransformado){
        SKAction* correrLiche =[SKAction repeatActionForever:[SKAction animateWithTextures:animacionesCorrerLicheFrames
                                                                               timePerFrame:0.2f
                                                                                     resize:NO
                                                                                    restore:YES]];
        SKAction *actionSequence = [SKAction sequence:@[correrLiche]];
         _personaje.xScale = fabs(_personaje.xScale) * orientacionDelPersonaje;
        [_personaje runAction:actionSequence];
    } else {
        _personaje.xScale = fabs(_personaje.xScale) * orientacionDelPersonaje;
        [_personaje runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:animacionesMoverseFrames
                                                                             timePerFrame:0.18f
                                                                                   resize:NO
                                                                                  restore:YES]]
                                                                                withKey:@"correr"];
    }
}

-(void)saltar{
    if(estoyTransformado){
       
    }else {
        [_personaje runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:animacionesSaltarKnight1Frames
                                                                             timePerFrame:0.18f
                                                                                   resize:NO
                                                                                  restore:YES]]
                                                                                    withKey:@"saltar"];
    }
    
    saltar = [SKAction moveByX:0 y:200 duration:0.6];
 //   [self runAction:[SKAction playSoundFileNamed:@"Jump.wav" waitForCompletion:NO]];
    [_personaje  runAction:saltar];
}

-(void)atacar{
    
    if(estoyTransformado){
        [_personaje runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:animacionesAtacarLicheFrames
                                                                             timePerFrame:0.25f
                                                                                   resize:NO
                                                                                  restore:YES]]
                                                                                    withKey:@"atacar"];
    }else {
        [_personaje runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:animacionesAtacarKnight1Frames
                                                                             timePerFrame:0.25f
                                                                                   resize:NO
                                                                                  restore:YES]]
                                                                                    withKey:@"atacar"];
    }
   
 }


-(void)estarQuieto{
    
    if(estoyTransformado){
        
        SKAction *idle = [SKAction repeatActionForever:[SKAction animateWithTextures:animacionesIdleLicheFrames
                                                                        timePerFrame:0.20f
                                                                              resize:NO
                                                                             restore:YES]];
        
        SKAction *actionSequence = [SKAction sequence:@[idle]];
        [_personaje runAction:actionSequence];
        
    }else {
        
        int numRandom = arc4random_uniform(3);
        
        NSMutableArray* animacionesAEjecutarse ;
        
        SKAction *delay = [SKAction waitForDuration:6];
        
        if(numRandom==0){
            animacionesAEjecutarse = animacionesIdleKnight1Frames;
        }else if (numRandom==1){
            animacionesAEjecutarse = animacionesIdleKnight2Frames;
        }else if(numRandom==2){
            animacionesAEjecutarse = animacionesIdleKnight3Frames;
        }
        
        SKAction *idle = [SKAction repeatActionForever:[SKAction animateWithTextures:animacionesAEjecutarse
                                                                        timePerFrame:0.25f
                                                                              resize:NO
                                                                             restore:YES]];
        
        SKAction *actionSequence = [SKAction sequence:@[delay,idle]];
        [_personaje runAction:actionSequence];
        
        
        
    }
    
}

- (void) transformacion {
    
    if (estoyVivo) {
        
        [_personaje removeAllActions];
        
       estoyTransformado=true;
        
       SKAction* sacarMedallon = [SKAction repeatAction:[SKAction animateWithTextures:animacionesTransformacion1Frames
                                                                      timePerFrame:0.3f
                                                                            resize:NO
                                                                           restore:YES] count:1];
        
        SKAction* resize = [SKAction scaleToSize:CGSizeMake(86, 67) duration:0.1f];
        
        SKAction* transformacion = [SKAction repeatAction:[SKAction animateWithTextures:animacionesTransformacionLicheFrames
                                                                           timePerFrame:0.3f
                                                                                 resize:NO
                                                                                restore:YES] count:1];
        
        SKAction* liche = [SKAction setTexture:[SKTexture textureWithImageNamed:@"Lich"]];
        
        SKAction *actionSequence = [SKAction sequence:@[sacarMedallon,resize,transformacion,liche]];
        
        [_personaje runAction:actionSequence];
    }
}

-(void)morir{
    
    [_personaje removeAllActions];
    
    [_personaje runAction:[SKAction repeatAction:[SKAction animateWithTextures:animacionesMuerteGuerreroFrames
                                                                  timePerFrame:1.0f
                                                                        resize:NO
                                                                       restore:NO] count:1]];
    
    estoyVivo = false;
    
     [_monstruo1 removeFromParent];
     [_monstruo2 removeFromParent];
}


-(void)compruebaVida{
    
    switch (_vida) {
            
        case 60:
            
            _corazon1.texture= [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            break;
            
        case 50:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartHalf"];
            break;
            
        case 40:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
        break;
            
        case 30:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartHalf"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            break;
            
        case 20:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartFull"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            break;
            
        case 10:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartHalf"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            break;
            
        case 0:
            _corazon1.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            _corazon2.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            _corazon3.texture = [SKTexture textureWithImageNamed:@"HeartEmpty"];
            
            [self morir];
            
            break;
            
    }
    
}


- (void)update:(NSTimeInterval)currentTime {
    
    _labelMonedas.text = [NSString stringWithFormat:@"%ld",_monedas];

    //La cámara seguirá al jugador en todo momento
    [self camaraSigueme];
    
    [self sigueAlJugador:_monstruo1];
    [self sigueAlJugador:_monstruo2];
    
    //Si estamos apretando algun boton
    if(estoyApretando){
        [ _personaje runAction:mover];
    }
    
    //Si el personaje "colisiona" con la tienda podrá realizar compras
    if (CGRectIntersectsRect(_personaje.frame, _tienda.frame)){
        _entrarTienda.hidden = false;
    } else {
        //Sino el botón de compra estará deshabilitado
        _entrarTienda.hidden = true;
        _menuTienda.hidden = true;
    }
}


-(void)camaraSigueme{
    personajePosX = _personaje.position.x + 66.0f;
    personajePosY = _personaje.position.y + 66.0f;
    _camara.position = CGPointMake(personajePosX, personajePosY);
}

-(void)parar{
    [_personaje removeAllActions];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self muevete:location];
}

- (void)muevete:(CGPoint)touchedPoint {
    
    [_personaje removeAllActions];
    
    SKNode *touchedNode = [self nodeAtPoint:touchedPoint];
    
    if ([touchedNode.name isEqualToString:@"botonIzquierda"] && estoyVivo) {
        
        estoyApretando = true;
        estoyQuieto = false;
        mover = [SKAction moveByX:-velocidadMovimientoPersonajeCaballero y:0.0 duration:1.0];
        orientacionDelPersonaje = -1;
       
        [self correr];
    }
    
    if ([touchedNode.name isEqualToString:@"botonDerecha"] && estoyVivo) {
        
        estoyApretando = true;
        estoyQuieto = false;
        mover = [SKAction moveByX:velocidadMovimientoPersonajeCaballero y:0.0 duration:1.0];
        orientacionDelPersonaje = 1;
       
        [self correr];
    }
    
    if ([touchedNode.name isEqualToString:@"botonAtacar"] && estoyVivo ){
        
        estoyAtacando=true;
        estoyQuieto = false;
        
        [self atacar];
        
    }
        
    if ([touchedNode.name isEqualToString:@"botonSaltar"] && estoyVivo){
      
        estoyQuieto = false;
        [self saltar];
    }
    
    //Si el botón para entrar a la tienda está visible, podremos pulsar en él para comprar
    if (!_entrarTienda.hidden && [touchedNode.name isEqualToString:@"EntrarTienda"] && estoyVivo) {
        _menuTienda.hidden = false;
        //Se escuchará el sonidito de entrar
       // [self runAction:[SKAction playSoundFileNamed:@"EntrarTienda.wav" waitForCompletion:NO]];
    } else if (![touchedNode.name isEqualToString:@"EntrarTienda"]) {
        //Si pulsamos sobre los objetos de la tienda esta NO se cerrará
        if ([touchedNode.name containsString:@"Comprar"]) {
            [self comprarObjeto:touchedNode]; //Para verificar qué estamos comprando
        } else {
            _menuTienda.hidden = true;
        }
    }
    
    //Si pulsas en la ruedecita, se abrirán las opciones
    if ([touchedNode.name isEqualToString:@"Options"] && estoyVivo){
        [self pausaElJuego];
    } else if (![touchedNode.name isEqualToString:@"GuardarYSalir"] && ![touchedNode.name isEqualToString:@"Options"]) {
        self.paused = false;
        _guardarYSalir.hidden = true;
    }
    
    //Método en el que si pulsamos la opción de "guardar y salir" saldremos del juego y guardaremos los datos
    if ([touchedNode.name isEqualToString:@"GuardarYSalir"]) {
        [self guardar];
        exit(0);
    }
}

- (void)pausaElJuego {
    //Se pausará el juego y entrará en acción el menú de configuración básico
    self.paused = true;
    _guardarYSalir.hidden = false;
    //Si la tienda estuviera abierta, se cerraría (vamos, ocultarla)
    if (!_menuTienda.hidden) {
        _menuTienda.hidden = true;
    }
}

//Cuando compramos un objeto en la tienda
- (void)comprarObjeto:(SKNode*)touchedNode {
    //Si intentamos comprar la vida
    if ([touchedNode.name isEqualToString:@"ComprarFullVida"]) {
        precioObjeto = 6;
        if (_monedas >= precioObjeto && _vida < 60) {
            _vida = 60;
            _monedas -= precioObjeto;
            [self compruebaVida];
        }
    }
    //Se actualiza nuestro dinero
    _labelMonedas.text = [NSString stringWithFormat:@"%ld",_monedas];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    estoyApretando = false;
    estoyAtacando = false;
    estoySaltando = false;
    estoyQuieto = true;
    [self parar];
    
    if (estoyVivo) {
         [self estarQuieto];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    //Si el personaje llega a atacar a los monstruos o al revés
    if (firstBody.categoryBitMask == monstruoCategoria || secondBody.categoryBitMask == monstruoCategoria){
        
        if(estoyAtacando && orientacionDelPersonaje!=orientacionDelMonstruo){
           
            [secondBody.node removeFromParent];
            _monedas ++;
            _labelMonedas.text = [NSString stringWithFormat:@"%ld",_monedas];
            
        } else {
            
            _vida -= 1;
            [self compruebaVida];
            
        }
    }
}

- (void)addMonster {
    _monstruo1 = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    _monstruo1.size = CGSizeMake(70, 57);
    _monstruo1.physicsBody = [SKPhysicsBody bodyWithTexture:_monstruo1.texture size:CGSizeMake(_monstruo1.size.width, _monstruo1.size.height)];
    _monstruo1.physicsBody.allowsRotation = false;
    _monstruo1.physicsBody.pinned = false;
    _monstruo1.physicsBody.affectedByGravity = true;
    _monstruo1.physicsBody.dynamic=true;
    _monstruo1.physicsBody.friction =1.0;
    _monstruo1.physicsBody.restitution =0.2;
    _monstruo1.physicsBody.mass = 0.03;
    //Las colisiones del monstruo
    _monstruo1.physicsBody.categoryBitMask = monstruoCategoria;
    _monstruo1.physicsBody.collisionBitMask = personajeCategoria;
    _monstruo1.physicsBody.fieldBitMask = personajeCategoria;
    //
    _monstruo1.zPosition = 1;
    _monstruo1.position = CGPointMake(_camara.position.x, 1);
    
    [self addChild:_monstruo1];
    
     _monstruo2 = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    _monstruo2.size = CGSizeMake(70, 57);
    _monstruo2.physicsBody = [SKPhysicsBody bodyWithTexture:_monstruo2.texture size:CGSizeMake(_monstruo2.size.width, _monstruo2.size.height)];
    _monstruo2.physicsBody.allowsRotation = false;
    _monstruo2.physicsBody.pinned = false;
    _monstruo2.physicsBody.affectedByGravity = true;
    _monstruo2.physicsBody.dynamic=true;
    _monstruo2.physicsBody.friction =1.0;
    _monstruo2.physicsBody.restitution =0.2;
    _monstruo2.physicsBody.mass = 0.03;
    //Colisiones
    _monstruo2.physicsBody.categoryBitMask =monstruoCategoria;
    _monstruo2.physicsBody.collisionBitMask =personajeCategoria;
    _monstruo2.physicsBody.fieldBitMask = personajeCategoria;
    //
    _monstruo2.zPosition = 1;
    _monstruo2.position = CGPointMake(_camara.position.x+40, 1);
    [self addChild:_monstruo2];
}

-(void)sigueAlJugador:(SKSpriteNode*)objeto{
    
    if(objeto.position.x > _personaje.position.x){
        orientacionDelMonstruo = -1;
        objeto.xScale = fabs(objeto.xScale) * orientacionDelMonstruo;
    }else{
        orientacionDelMonstruo = 1;
        objeto.xScale = fabs(objeto.xScale) * orientacionDelMonstruo;
    }
    
    seguir = [SKAction moveToX: _personaje.position.x duration:6];
    [objeto runAction:seguir];
    
}

-(void)guardar{
    [GameData guardarVida:_vida yMonedas:_monedas yEscena:self.scene.name];
}

-(void)pasarDeEscena {
    GKScene *scene = [GKScene sceneWithFileNamed:@"GameScene_2"];
    GameScene *sceneNode = (GameScene*)scene.rootNode;
    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    sceneNode.monedas = [self monedas];
    sceneNode.vida =  [self vida];
    
    skView.showsFPS = true;
    
    [skView presentScene:sceneNode];
}

@end
