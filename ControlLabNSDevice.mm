//
//  ControlLabNSDevice.mm
//  ControlLab
//
//  Created by Pablo Casado Varela on 20/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabNSDevice.h"

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

@implementation ControlLabNSDevice {
    int kXMaxLandscapeRight;
    int kYMaxLandscapeRight;


}

- (id) initWithFirstCoordinate:(SceneVertex)firstC andSecond:(SceneVertex)secondC andThird:(SceneVertex)thirdC andFourth:(SceneVertex)fourthC {
    self = [super init];
    if (self) {
        firstCoordinate = firstC;
        secondCoordinate = secondC;
        thirdCoordinate = thirdC;
        fourthCoordinate = fourthC;

    }
    return self;
}

- (void) setIdDevice:(NSString *)identify andName:(NSString *)nameDevice andType:(kDevices)type {
    self->name = nameDevice;
    self->identificador = identify;
    self->typeOfDevices = type;

}

- (bool) isSelected:(CGPoint)point withModelview:(float*)modelview andProjection:(float*)projection andViewPort:(int*)viewport {
    bool selected = false;
    float coord[4][3];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *deviceType = [UIDevice currentDevice].model;

    if([deviceType isEqualToString:@"iPhone"]) {
        NSLog(@"Device iPhone");
        if (orientation == UIInterfaceOrientationPortrait) {

        }
        else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {

        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            NSLog(@"Landscape Left");
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight) {
            kXMaxLandscapeRight = 568;
            kYMaxLandscapeRight = 320;

        }
    }
    else {
        //        NSLog(@"Device iPad");
        if (orientation == UIInterfaceOrientationPortrait) {

        }
        else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {

        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            NSLog(@"Landscape Left");
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight) {
            //NSLog(@"Landscape Right");
            kXMaxLandscapeRight = 1028;
            kYMaxLandscapeRight = 768;

            // DETECCION
            glhProjectf(secondCoordinate.position[0], secondCoordinate.position[1], secondCoordinate.position[2], modelview, projection, viewport, coord[0]);
            //            NSLog(@"Esquina Superior Derecha puerta X: %.f, Y: %.f, Z: %f", coord[0][0], (float)viewport[3] - coord[0][1], coord[0][2]);

            glhProjectf(fourthCoordinate.position[0], fourthCoordinate.position[1], fourthCoordinate.position[2], modelview, projection, viewport, coord[1]);
            //            NSLog(@"Esquina Superior Izquierda puerta X: %.f, Y: %.f, Z: %f", coord[1][0], (float)viewport[3] - coord[1][1], coord[1][2]);

            glhProjectf(firstCoordinate.position[0], firstCoordinate.position[1], firstCoordinate.position[2], modelview, projection, viewport, coord[2]);
            //            NSLog(@"Esquina inferior Derecha puerta X: %.f, Y: %.f, Z: %f", coord[2][0], (float)viewport[3] - coord[2][1], coord[2][2]);

            glhProjectf(thirdCoordinate.position[0], thirdCoordinate.position[1], thirdCoordinate.position[2], modelview, projection, viewport, coord[3]);
            //            NSLog(@"Esquina inferior izquierda puerta X: %.f, Y: %.f, Z: %f", coord[3][0], (float)viewport[3] - coord[3][1], coord[3][2]);


            float xMin, xMax, yMin, yMax, zCoordinate;
            xMin = yMin = 1028.0;
            xMax = yMax = zCoordinate = 0.0;
            for (int i = 0; i < 4; i++) {
                if (coord[i][0] > xMax) {
                    xMax = coord[i][0];
                }
                if (coord[i][0] < xMin) {
                    xMin = coord[i][0];
                }
                if ((float)viewport[3] - coord[i][1] > yMax) {
                    yMax = (float)viewport[3] - coord[i][1];
                }
                if ((float)viewport[3] - coord[i][1] < yMin) {
                    yMin = (float)viewport[3] - coord[i][1];
                }
                if (coord[i][2] < 0.0 || coord[i][2] > 1.0) {
                    zCoordinate = coord[i][2];
                }

            }


            if (yMin < 0.0) {
                yMin = 0.0;
            }
            if (yMax > kYMaxLandscapeRight) {
                yMax = kYMaxLandscapeRight;
            }
            if (xMin < 0.0) {
                xMin = 0.0;
            }
            if (xMax > kXMaxLandscapeRight) {
                xMax = kXMaxLandscapeRight;
            }

            //            NSLog(@"X Max: %.f, Min: %.f", xMax, xMin);
            //            NSLog(@"Y Max: %.f, Min: %.f", yMax, yMin);
            //            NSLog(@"Touch X: %f, Y: %f", point.x, point.y);

            if (point.x > xMin && point.x < xMax) {
                if (point.y > yMin && point.y < yMax) {
                    if (zCoordinate == 0.0) {
                        //                        NSLog(@"Device Tocado");
                        //                        NSLog(@"Coordenada Z: %f", zCoordinate);
                        selected = YES;
                    }
                    
                }
            }
    }


    }

    return selected;
}

- (kDevices) getTypeOfDevice {
    return self->typeOfDevices;
}
- (NSString *) getName {
    return self->name;
}

-(NSString *) getIdentificador {
    return self->identificador;
}

@end
