//
//  MateriaViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 24/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "MateriaViewController.h"
#import "ViewController.h"
#import "PoblacionViewController.h"
#import "IdiomaViewController.h"

@interface MateriaViewController (){
    NSArray *parapicker;
}

@end

@implementation MateriaViewController
@synthesize poblacion, provincia, tipos;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tipoApasar=@"";
    
    array=[[NSMutableArray alloc]init];
    identificador=[[NSMutableArray alloc]init];
    
    ViewController *vistafuncional = [[ViewController alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       parapicker=[vistafuncional leerConsultaMysql:6 texto:poblacion];
                       
                       //int cont=0;
                       for (int cont=0;cont<[parapicker count];cont++) {
                           
                           [identificador addObject:[[parapicker objectAtIndex:cont] objectForKey:@"id"]];
                           
                           NSString *prov=[[parapicker objectAtIndex:cont] objectForKey:@"nombre"];
                           prov=[prov stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           
                           prov=[prov stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           
                           [array addObject:prov];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [tipos reloadAllComponents];
                                          [vistacarga setHidden:YES];
                                      });
                   });

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//PICKER METODOS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    tipoApasar=[[NSString alloc]initWithString:[identificador objectAtIndex:row]];
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [array count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [array objectAtIndex:row];
}


//PASAR DATOS

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"deTipo"]) {
        PoblacionViewController *segundoView = [segue destinationViewController];
        segundoView.TextoPasar = provincia;
    }
    if ([[segue identifier] isEqualToString:@"irAidioma"]) {
        IdiomaViewController *segundoView = [segue destinationViewController];
        if([tipoApasar isEqual:@""]){
            tipoApasar=[[NSString alloc]initWithString:[identificador objectAtIndex:0]];
        }
        segundoView.tipo = tipoApasar;
        segundoView.poblacion = poblacion;
        segundoView.provincia = provincia;
    }
}

@end
