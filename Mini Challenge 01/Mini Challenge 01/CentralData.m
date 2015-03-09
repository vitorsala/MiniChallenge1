//
//  CentralData.m
//  Mini Challenge 01
//
//  Created by William Hong Jun Cho on 3/5/15.
//  Copyright (c) 2015 Nerf. All rights reserved.
//

#import "CentralData.h"

static NSMutableArray *parkingLots;
@implementation CentralData


+(void)initData {
    parkingLots = [[NSMutableArray alloc]initWithObjects:
                   [[ParkingLot alloc] initName:@"Cbe Estacionamentos" opSchedule:0 closeSchedule:0 price:15.0 adress:@"Rua Itacolomi, 333" latitude:-23.547200 longitude: -46.656579],
                   [[ParkingLot alloc] initName:@"RRM Estacionamentos" opSchedule:7 closeSchedule:19 price:9.0 adress:@"Avenida Angélica, 1761" latitude:-23.548277 longitude: -46.658669],
                   [[ParkingLot alloc] initName:@"Ita Park Estacionamento" opSchedule:0 closeSchedule:0 price:17.0 adress:@"Avenida Higienópolis, 431" latitude:-23.544656 longitude: -46.654653],
                   [[ParkingLot alloc] initName:@"RJ Park Administração" opSchedule:6 closeSchedule:20 price:8.0 adress:@"Avenida Higienópolis, 890" latitude:-23.541768 longitude: -46.660056],
                   [[ParkingLot alloc] initName:@"Estag Auto Posto Estacionamento" opSchedule:5 closeSchedule:20 price:5.0 adress:@"Rua Dr Veiga Filho, 176 " latitude:-23.541438 longitude: -46.656661],
                   [[ParkingLot alloc] initName:@"Orivaldo`s Park" opSchedule:0 closeSchedule:0 price:20.0 adress:@"Rua Ceará, 500" latitude:-23.547574 longitude: -46.661460],
                   [[ParkingLot alloc] initName:@"Itápolis Estacionamento" opSchedule:7 closeSchedule:19 price:7.50 adress:@"Rua Itápolis, 940" latitude:-23.551524 longitude: -46.663272],
                   [[ParkingLot alloc] initName:@"Itaperuna Park Estacionaento" opSchedule:5 closeSchedule:22 price:9.0 adress:@"Rua Itaperuna, 350" latitude:-23.551016 longitude: -46.667434],
                   [[ParkingLot alloc] initName:@"Estacionamento Angatuba" opSchedule:0 closeSchedule:0 price:12.50 adress:@"Rua Angatuba, 100" latitude:-23.551300 longitude: -46.666520],
                   [[ParkingLot alloc] initName:@"Porto Park Estacionamentos e Serviços" opSchedule:5 closeSchedule:21 price:10.0 adress:@"Rua Alagoas, 974" latitude:-23.544042 longitude: -46.663321],
                   [[ParkingLot alloc] initName:@"Piaui Park" opSchedule:0 closeSchedule:0 price:16.0 adress:@"Rua Piaui, 300" latitude:-23.543414 longitude: -46.661803],
                   [[ParkingLot alloc] initName:@"RRM Estacionamentos" opSchedule:7 closeSchedule:19 price:9.0 adress:@"Rua Barão de Tatuí, 200" latitude:-23.538041 longitude: -46.653641],
                   [[ParkingLot alloc] initName:@"Estacionamento Jesuino" opSchedule:8 closeSchedule:22 price:5.0 adress:@"Rua Jesuíno Pascoal, 50" latitude:-23.541157 longitude: -46.649665],
                   [[ParkingLot alloc] initName:@"Cezar Park Estacionamento" opSchedule:0 closeSchedule:0 price:17.0 adress:@"Rua Santa Isabel, 287" latitude:-23.542624 longitude: -46.648425],
                   [[ParkingLot alloc] initName:@"New City Estacionamento" opSchedule:7 closeSchedule:23 price:10.0 adress:@"Rua General Jardim, 522" latitude:-23.544494 longitude: -46.649551],
                   [[ParkingLot alloc] initName:@"Estacionamento Gilson" opSchedule:8 closeSchedule:20 price:4.0 adress:@"Rua Visc. de Ouro Preto, 72" latitude:-23.549941 longitude: -46.650596],
                   [[ParkingLot alloc] initName:@"Patropi" opSchedule:0 closeSchedule:0 price:13.0 adress:@"Rua Augusta, 200" latitude:-23.551004 longitude: -46.648392],
                   [[ParkingLot alloc] initName:@"Kasa de Gas Veicular e Estacionamento" opSchedule:6 closeSchedule:19 price:7.0 adress:@"Rua Augusta, 923" latitude:-23.552979 longitude: -46.653942],
                   [[ParkingLot alloc] initName:@"Royal SP Estacionamento" opSchedule:6 closeSchedule:23 price:10.0 adress:@"Rua Frei Caneca, 1024" latitude:-23.556830 longitude: -46.656911],
                   [[ParkingLot alloc] initName:@"Estapar" opSchedule:7 closeSchedule:21 price:9.0 adress:@"R. Frei Caneca, 1409" latitude:-23.558162 longitude: -46.658380],
                   [[ParkingLot alloc] initName:@"Evon Park" opSchedule:0 closeSchedule:0 price:11.0 adress:@"Alameda Jaú, 1456" latitude:-23.560152 longitude: -46.661433],
                   [[ParkingLot alloc] initName:@"Rede Park" opSchedule:10 closeSchedule:2 price:8.0 adress:@"Alameda Santos, 2159" latitude:-23.558760 longitude: -46.661857],
                   [[ParkingLot alloc] initName:@"Star Fix Estacionamento" opSchedule:7 closeSchedule:23 price:12.0 adress:@"Alameda Santos, 1834" latitude:-23.561513 longitude: -46.658723], nil];
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.564221 longitude: -46.659507],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.565074 longitude: -46.655426],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.563324 longitude: -46.652977],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.559059 longitude: -46.650610],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555483 longitude: -46.653026],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.553283 longitude: -46.648586],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.555199 longitude: -46.645027],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.551907 longitude: -46.644130],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.545182 longitude: -46.644463],
//                   [[ParkingLot alloc] initName:@"" opSchedule:0 closeSchedule:0 price:0.0 adress:@"" latitude:-23.544299 longitude: -46.646471],
//                   nil];
}

+(NSMutableArray *)getParkingLots {
    return parkingLots;
}

+(NSArray *)getClosestFrom:(CLLocation *)loc maxDistance:(float)maxDistance {
    NSMutableArray *p = [[NSMutableArray alloc]init];
    for (ParkingLot *pl in parkingLots) {
        double dist = [loc distanceFromLocation:pl.location];
        if(dist <= maxDistance) {
            [p addObject:pl];
        }
    }
    
    return p;
}



@end
