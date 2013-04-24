//
//  ControlLabViewController-iPhone.mm
//  ControlLab
//
//  Created by Pablo Casado Varela on 15/04/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabViewController-iPhone.h"

@interface ControlLabViewController_iPhone (){
    NSArray *textures;
    GLKTextureInfo *textureFront;
    GLKTextureInfo *textureLeft;
    GLKTextureInfo *textureBack;
    GLKTextureInfo *textureRight;
    GLKTextureInfo *textureTop;
    GLKTextureInfo *textureBottom;
    CMMotionManager *mm;
    NSOperationQueue *queueAccelerometer;
    NSOperationQueue *queueGyroscope;
    float factor;
    float factorUpDown;
    float ant;
    float antUpDown;

    UISwitch *onoff;
    GLfloat __modelview[16];
    GLfloat __projection[16];
    GLint __viewport[4];
    float kYMaxLandscapeRight;
    float kXMaxLandscapeRight;


}

@end

@implementation ControlLabViewController_iPhone

#pragma mark - Data Structures

#define kFilteringFactor 0.1
#define kAccelerometerFrequency 60.0 //Hz
#define kFactorUpdate 0.01

@synthesize baseEffect;
@synthesize glView;


typedef struct {
    GLfloat position[3];
    GLfloat color[4];
} SceneVertex;


typedef enum {
    kFaceFront = 0,
    kFaceLeft = 1,
    kFaceBack = 2,
    kFaceRight = 3,
    kFaceBottom = 4,
    kFaceTop = 5
} kFaceCubeType;

typedef enum {
    kWindows,
    kDoors
} kDevices;



static const GLfloat textureCoordinates [] = {
    1.0,0.0,
    1.0,1.0,
    0.0,0.0,
    0.0,1.0
};

static const SceneVertex cubeFrontVertex [] = {
    {{-5.0f, -5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//0
    {{-5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//1
    {{ 5.0f, -5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//2
    {{ 5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}} //3
};
static const SceneVertex cubeRightVertex [] = {
    {{-5.0f, -5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//4
    {{-5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//5
    {{-5.0f, -5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//6
    {{-5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}} //7
};
static const SceneVertex cubeBackVertex [] = {
    {{ 5.0f, -5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//8
    {{ 5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//9
    {{-5.0f, -5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//10
    {{-5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}} //11
};
static const SceneVertex cubeLeftVertex [] = {
    {{ 5.0f, -5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//12
    {{ 5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//13
    {{ 5.0f, -5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//14
    {{ 5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}} //15
};
static const SceneVertex cubeBottomVertex [] = {
    {{-5.0f, -5.0f,-5.0f}, { 0.0f, 0.1f, 0.1f, 1.0f}},//16
    {{-5.0f, -5.0f, 5.0f}, { 0.0f, 0.1f, 0.1f, 1.0f}},//17
    {{ 5.0f, -5.0f,-5.0f}, { 0.0f, 0.1f, 0.1f, 1.0f}},//18
    {{ 5.0f, -5.0f, 5.0f}, { 0.0f, 0.1f, 0.1f, 1.0f}} //19
};
static const SceneVertex cubeTopVertex [] = {
    {{-5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//20
    {{-5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//21
    {{ 5.0f,  5.0f, 5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}},//22
    {{ 5.0f,  5.0f,-5.0f}, { 0.1f, 0.1f, 0.1f, 1.0f}} //23
};


static const SceneVertex windowsA [] = {
    {{-1.35f, -0.5f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//0
    {{-1.35f,  2.3f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//1
    {{ 0.2f, -0.5f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//2
    {{ 0.2f,  2.3f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}} //3
};
static const SceneVertex doorA [] = {
    {{-3.9f, -1.35f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//0
    {{-3.9f,  1.7f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//1
    {{-2.4f, -1.35f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}},//2
    {{-2.4f,  1.7f, 4.95f}, { 0.1f, 0.1f, 0.1f, 0.6f}} //3
};

#pragma mark - Actualization Data Rotation

- (void) updateFactor:(float)fact {
    factor += fact;
}

- (void) updateFactorUpDown:(float)fact {
    factorUpDown += fact;

    if (factorUpDown > 3.14/2 ) {
        factorUpDown = 3.14/2;
    }
    else if (factorUpDown < -3.14/2) {
        factorUpDown = -3.14/2;
    }
}



- (void)pan:(UIPanGestureRecognizer *)gesture {
    float x = [gesture locationInView:self.view].x;
    float y = [gesture locationInView:self.view].y;

    float fromLeftToRight = x - ant;
    float fromUptoDown = y - antUpDown;

    if (fromLeftToRight > 0.5) {
        [self updateFactor:0.03];

    }
    else if (fromLeftToRight < -0.5){
        [self updateFactor:-0.03];

    }
    else
        [self updateFactor:0.0];

    if (fromUptoDown > 0.5) {
        [self updateFactorUpDown:-0.03];

    }
    else if (fromUptoDown < -0.5){
        [self updateFactorUpDown:0.03];

    }
    else
        [self updateFactorUpDown:0.0];
    ant = x;
    antUpDown = y;


}


- (void)tap:(UIPanGestureRecognizer *)gesture {

    CGPoint point = [gesture locationInView:self.view];

    [self getOGLPos:point];

}

- (void)getMatrixOpenGL {
    //    glGetIntegerv( GL_VIEWPORT, __viewport );
    __viewport[1] = 0;
    __viewport[1] = 0;
    __viewport[2] = 568;
    __viewport[3] = 320;

    GLKMatrix4 modelview = baseEffect.transform.modelviewMatrix;
    GLKMatrix4 projection = baseEffect.transform.projectionMatrix;


    __modelview[0] = modelview.m00; __projection[0] = projection.m00;
    __modelview[1] = modelview.m01; __projection[1] = projection.m01;
    __modelview[2] = modelview.m02; __projection[2] = projection.m02;
    __modelview[3] = modelview.m03; __projection[3] = projection.m03;
    __modelview[4] = modelview.m10; __projection[4] = projection.m10;
    __modelview[5] = modelview.m11; __projection[5] = projection.m11;
    __modelview[6] = modelview.m12; __projection[6] = projection.m12;
    __modelview[7] = modelview.m13; __projection[7] = projection.m13;
    __modelview[8] = modelview.m20; __projection[8] = projection.m20;
    __modelview[9] = modelview.m21; __projection[9] = projection.m21;
    __modelview[10] = modelview.m22; __projection[10] = projection.m22;
    __modelview[11] = modelview.m23; __projection[11] = projection.m23;
    __modelview[12] = modelview.m30; __projection[12] = projection.m30;
    __modelview[13] = modelview.m31; __projection[13] = projection.m31;
    __modelview[14] = modelview.m32; __projection[14] = projection.m32;
    __modelview[15] = modelview.m33; __projection[15] = projection.m33;

}

-(void) getOGLPos:(CGPoint)winPos
{
    // I am doing this once at the beginning when I set the perspective view

    float coord[4][3];


    [self getMatrixOpenGL];

    // Distinguir Portrait y Lanscape
    // Control Device Orientation
    UIInterfaceOrientation isOrientation = self.interfaceOrientation;
    if (isOrientation == UIInterfaceOrientationPortrait) {

    }
    else if (isOrientation == UIInterfaceOrientationPortraitUpsideDown) {

    }
    else if (isOrientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"Landscape Left");
    }
    else if (isOrientation == UIInterfaceOrientationLandscapeRight) {


        // DETECCION PUERTA
        glhProjectf(-3.9f, 1.7f, 4.95f, __modelview, __projection, __viewport, coord[0]);
        //                NSLog(@"Esquina Superior Derecha puerta X: %.f, Y: %.f", coord[0][0], (float)__viewport[3] - coord[0][1]);

        glhProjectf(-2.4f, 1.7f, 4.95f, __modelview, __projection, __viewport, coord[1]);
        //                NSLog(@"Esquina Superior Izquierda puerta X: %.f, Y: %.f", coord[1][0], (float)__viewport[3] - coord[1][1]);

        glhProjectf(-3.9f, -1.35f, 4.95f, __modelview, __projection, __viewport, coord[2]);
        //                NSLog(@"Esquina inferior Derecha puerta X: %.f, Y: %.f", coord[2][0], (float)__viewport[3] - coord[2][1]);

        glhProjectf(-2.4f, -1.35f, 4.95f, __modelview, __projection, __viewport, coord[3]);
        //                NSLog(@"Esquina inferior izquierda puerta X: %.f, Y: %.f", coord[3][0], (float)__viewport[3] - coord[3][1]);

        //NSLog(@"Touch: X: %.f, Y: %.f", winPos.x, winPos.y);

        

        float xMin, xMax, yMin, yMax, zCoordinate;
        xMin = yMin = 568.0;
        xMax = yMax = zCoordinate = 0.0;
        for (int i = 0; i < 4; i++) {
            if (coord[i][0] > xMax) {
                xMax = coord[i][0];
            }
            if (coord[i][0] < xMin) {
                xMin = coord[i][0];
            }
            if ((float)__viewport[3] - coord[i][1] > yMax) {
                yMax = (float)__viewport[3] - coord[i][1];
            }
            if ((float)__viewport[3] - coord[i][1] < yMin) {
                yMin = (float)__viewport[3] - coord[i][1];
            }
            if (coord[i][2] < 0.0 || coord[i][2] > 1.0) {
                zCoordinate = coord[i][2];
            }

        }

        if (yMin < 0.0) {
            yMin = 0.0;
        }
        if (yMax > 320.0) {
            yMax = 320.0;
        }
        if (xMin < 0.0) {
            xMin = 0.0;
        }
        if (xMax > 568.0) {
            xMax = 568.0;
        }


        if (winPos.x > xMin && winPos.x < xMax) {
            if (winPos.y > yMin && winPos.y < yMax) {
                if (zCoordinate == 0.0) {
                    //                    NSLog(@"Puerta Tocada");
                    [self drawInterfaceDeviceDoor];
                }
            }
        }


        // DETECCION VENTANA
        glhProjectf(-1.35f, 2.3f, 4.95f, __modelview, __projection, __viewport, coord[0]);
        //                NSLog(@"Esquina Superior Derecha puerta X: %.f, Y: %.f", coord[0][0], (float)__viewport[3] - coord[0][1]);

        glhProjectf(-0.2f, 2.3f, 4.95f, __modelview, __projection, __viewport, coord[1]);
        //                NSLog(@"Esquina Superior Izquierda puerta X: %.f, Y: %.f", coord[1][0], (float)__viewport[3] - coord[1][1]);

        glhProjectf(-1.35f, -0.5f, 4.95f, __modelview, __projection, __viewport, coord[2]);
        //                NSLog(@"Esquina inferior Derecha puerta X: %.f, Y: %.f", coord[2][0], (float)__viewport[3] - coord[2][1]);

        glhProjectf(0.2f, -0.5f, 4.95f, __modelview, __projection, __viewport, coord[3]);
        //                NSLog(@"Esquina inferior izquierda puerta X: %.f, Y: %.f", coord[3][0], (float)__viewport[3] - coord[3][1]);

        NSLog(@"Touch: X: %.f, Y: %.f", winPos.x, winPos.y);



        xMin = yMin = 568.0;
        xMax = yMax = zCoordinate = 0.0;
        for (int i = 0; i < 4; i++) {
            if (coord[i][0] > xMax) {
                xMax = coord[i][0];
            }
            if (coord[i][0] < xMin) {
                xMin = coord[i][0];
            }
            if ((float)__viewport[3] - coord[i][1] > yMax) {
                yMax = (float)__viewport[3] - coord[i][1];
            }
            if ((float)__viewport[3] - coord[i][1] < yMin) {
                yMin = (float)__viewport[3] - coord[i][1];
            }
            if (coord[i][2] < 0.0 || coord[i][2] > 1.0) {
                zCoordinate = coord[i][2];
            }

        }

        if (yMin < 0.0) {
            yMin = 0.0;
        }
        if (yMax > 320.0) {
            yMax = 320.0;
        }
        if (xMin < 0.0) {
            xMin = 0.0;
        }
        if (xMax > 568.0) {
            xMax = 568.0;
        }


        if (winPos.x > xMin && winPos.x < xMax) {
            if (winPos.y > yMin && winPos.y < yMax) {
                if (zCoordinate == 0.0 ) {
                    //                    NSLog(@"Ventana Tocada");
                    [self drawInterfaceDeviceWindow];
                }
            }
        }


    }
}

- (void) drawInterfaceDeviceDoor {
    ControlLabkDoorViewController *vc = [[ControlLabkDoorViewController alloc] init];
    vc.title = @"Device Door";
    popover = [[FPPopoverController alloc ]initWithViewController:vc];
    popover.delegate = self;
    popover.contentSize = CGSizeMake(300, 300);
    popover.arrowDirection = FPPopoverNoArrow;
    popover.tint = FPPopoverLightGrayTint;

    //    NSLog(@"Draw Interface Device Door");
    [popover presentPopoverFromPoint:CGPointMake(10, 10)];
    [self stopGyroscope];


}

- (void) drawInterfaceDeviceWindow {
    ControlLabkWindowViewController *vc = [[ControlLabkWindowViewController alloc] init];
    vc.title = @"Device Window";
    popover = [[FPPopoverController alloc ]initWithViewController:vc];
    popover.delegate = self;
    popover.contentSize = CGSizeMake(300, 300);
    popover.arrowDirection = FPPopoverNoArrow;
    popover.tint = FPPopoverLightGrayTint;
    //    NSLog(@"Draw Interface Device Window");
    [popover presentPopoverFromPoint:CGPointMake(10, 10)];
    [self stopGyroscope];
}



-(void) popoverControllerDidDismissPopover:(FPPopoverController *)popoverController {
    NSLog(@"Popover dismissed");
    [self loadGyroscope];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSLog(@"%@",[[UIDevice currentDevice] model]);

    NSString *deviceType = [UIDevice currentDevice].model;

    if([deviceType isEqualToString:@"iPhone"]) {

    }
    else {

    }
    struct utsname systemInfo;

    uname(&systemInfo);
    NSString *modelName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if([modelName isEqualToString:@"iPhone3,1"]) {
        modelName = @"iPhone 4";
        kYMaxLandscapeRight = 320.0;
        kXMaxLandscapeRight = 560.0;
    }
    else if([modelName isEqualToString:@"iPhone4,1"]) {
        modelName = @"iPhone 4S";
        kYMaxLandscapeRight = 320.0;
        kXMaxLandscapeRight = 560.0;
    }
    else if([modelName isEqualToString:@"iPhone5,1"]) {
        modelName = @"iPhone 5";
        kYMaxLandscapeRight = 320.0;
        kXMaxLandscapeRight = 560.0;
    }

    NSLog(@"Model %@", modelName);


    
    factor = 0.0;
    factorUpDown = 0.0;

    mm = [[CMMotionManager alloc] init];

    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"View Controller´s view is not a GLKView");

    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];

    self.delegate = self;

    baseEffect = [[GLKBaseEffect alloc] init];


    [self loadTextures];

    [self loadGyroscope];
    // Añado reconocimiento de arrastre de imagen
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
    // Añado reconocimiento de tap de imagen
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];

    ControlLabCustomToolBar *toolbar = [[ControlLabCustomToolBar alloc] init];
    toolbar.backgroundColor = [UIColor grayColor];

    [self.view addSubview:toolbar];


}


#pragma mark - Gyroscope Inicializa la carga de los datos del giroscopio

- (void) loadGyroscope {


    if ([mm isGyroAvailable]) {
        if ([mm isGyroActive] == NO) {
            [mm setGyroUpdateInterval:1.0f / kAccelerometerFrequency];
            queueGyroscope = [[NSOperationQueue alloc] init];
            [mm startGyroUpdatesToQueue:queueGyroscope withHandler:^(CMGyroData *gyroData, NSError *error){

                // Control Device Orientation
                UIInterfaceOrientation isOrientation = self.interfaceOrientation;

                //                NSLog(@"Rotation Rate: %f", gyroData.rotationRate.x);
                //                if (abs((float)gyroData.rotationRate.x)> 0.005 || abs((float)gyroData.rotationRate.y)> 0.005) {
                if (isOrientation == UIInterfaceOrientationPortrait) {

                    [self updateFactor:-gyroData.rotationRate.y * kFactorUpdate];
                    [self updateFactorUpDown:gyroData.rotationRate.x * kFactorUpdate];
                }
                else if (isOrientation == UIInterfaceOrientationPortraitUpsideDown) {

                    [self updateFactor:gyroData.rotationRate.y * kFactorUpdate];
                    [self updateFactorUpDown:-gyroData.rotationRate.x * kFactorUpdate];
                }
                else if (isOrientation == UIInterfaceOrientationLandscapeLeft) {

                    [self updateFactor:gyroData.rotationRate.x * kFactorUpdate];
                    [self updateFactorUpDown:gyroData.rotationRate.y * kFactorUpdate];
                }
                else if (isOrientation == UIInterfaceOrientationLandscapeRight) {

                    [self updateFactor:-gyroData.rotationRate.x * kFactorUpdate];
                    [self updateFactorUpDown:-gyroData.rotationRate.y * kFactorUpdate];
                }

                //}

            }];
        }
    }


}

- (void) stopGyroscope{
    [mm stopGyroUpdates];

}


#pragma mark - Carga Texturas

- (void) loadTextures {

    UIImage *image = [UIImage imageNamed:@"FRONT_LIGHT_ON.png"];
    NSError *error;
    textureFront = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"LEFT_LIGHT_ON.png"];
    textureLeft = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"BACK_LIGHT_ON.png"];
    textureBack = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"RIGHT_LIGHT_ON.png"];
    textureRight = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"BOTTOM_LIGHT_ON.png"];
    textureBottom = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"TOP_LIGHT_ON.png"];
    textureTop = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);


}

- (void) tearDownGL {
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Did Receive Memory Warning");
}


#pragma mark - Process Drawing OpenGL ES

-  (void) glkView:(GLKView *)view drawInRect:(CGRect)rect {
    //    NSLog(@"Draw In Rect");

    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    baseEffect.texture2d0.enabled = TRUE;
    baseEffect.texture2d0.envMode = GLKTextureEnvModeReplace;



    GLKMatrix4 matrix = GLKMatrix4Multiply(GLKMatrix4MakeXRotation(factorUpDown),GLKMatrix4MakeYRotation(factor));


    baseEffect.transform.modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeLookAt(0, 0, -3, 0, 0, -1, 0, 1, 0), matrix);
    //    baseEffect.transform.modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4Make    // Perspectiva 60º

    //    baseEffect.transform.projectionMatrix = GLKMatrix4MakePerspective(1.047, 1024 / 768, 0.1, -20);
    baseEffect.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(45), 560/320,0.1 ,20);

    [baseEffect prepareToDraw];


    // Habilito Color, Posicion y Textura
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);

    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, textureCoordinates);


    // Cara FRONT #########################################

    [self drawFaceCube:kFaceFront];

    // Cara LEFT #########################################

    [self drawFaceCube:kFaceLeft];

    // Cara BACK #########################################

    [self drawFaceCube:kFaceBack];

    // Cara RIGHT #########################################

    [self drawFaceCube:kFaceRight];

    // Cara TOP #########################################

    [self drawFaceCube:kFaceTop];

    // Cara BOTTOM #########################################

    [self drawFaceCube:kFaceBottom];



    // Deshabilito Color, Posicion y Textura

    baseEffect.texture2d0.enabled = FALSE;
    glDisableVertexAttribArray(GLKVertexAttribColor);
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribTexCoord0);



    [self tearDownGL];

    // Draw Devices #########################################
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);

    baseEffect.useConstantColor = YES;
    [baseEffect prepareToDraw];


    //    [self drawDevice:kWindows];
    //    [self drawDevice:kDoors];


    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);

    glDisable(GL_BLEND);

}


- (void) drawDevice: (kDevices) type {
    switch (type) {
        case kWindows:
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &windowsA[0].position);
            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &windowsA[0].color);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            break;
        case kDoors:


            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &doorA[0].position);
            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &doorA[0].color);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            break;

        default:
            break;
    }
}
- (void) drawFaceCube: (kFaceCubeType) type {
    switch (type) {
        case kFaceFront:
            //            baseEffect.texture2d0.target = textureFront.target;
            baseEffect.texture2d0.name = textureFront.name;
            [baseEffect prepareToDraw];

            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeFrontVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeFrontVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

            break;
        case kFaceLeft:
            //            baseEffect.texture2d0.target = textureLeft.target;
            baseEffect.texture2d0.name = textureLeft.name;
            [baseEffect prepareToDraw];

            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeLeftVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeLeftVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

            break;
        case kFaceBack:
            //            baseEffect.texture2d0.target = textureBack.target;
            baseEffect.texture2d0.name = textureBack.name;
            [baseEffect prepareToDraw];

            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeBackVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeBackVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

            break;
        case kFaceRight:
            //            baseEffect.texture2d0.target = textureRight.target;
            baseEffect.texture2d0.name = textureRight.name;
            [baseEffect prepareToDraw];

            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeRightVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeRightVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

            break;
        case kFaceBottom:
            //            baseEffect.texture2d0.target = textureTop.target;
            baseEffect.texture2d0.name = textureTop.name;
            [baseEffect prepareToDraw];

            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeTopVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeTopVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            
            break;
        case kFaceTop:
            //            baseEffect.texture2d0.target = textureBottom.target;
            baseEffect.texture2d0.name = textureBottom.name;
            [baseEffect prepareToDraw];
            
            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeBottomVertex[0].color);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), &cubeBottomVertex[0].position);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            
            break;
            
        default:
            break;
    }
}



- (void) glkViewControllerUpdate:(GLKViewController *)controller {
    
    
    
}



@end

