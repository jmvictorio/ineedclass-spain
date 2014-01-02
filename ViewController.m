//
//  ViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 10/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize rows;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)compartir:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"COMPARTIR" message:@"Comparte la App con tus amig@s" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Twitter", @"Facebook",nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        [self publicarEnTwitter];
    }
    else if (buttonIndex == 2)
    {
        [self publicarEnFacebook];
    }
}

- (void)publicarEnTwitter {
    // creamos una instancia usando el singleton
    SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"UPS" message:@"Parece ser que no tienes configurada la cuenta de Twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // verificamos que exista una cuenta configurada y que se pueda usar esta característica
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        // manipulamos los mensajes de error si hay usando la propiedad completionHandler
        SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result)
        {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    //NSLog(@"La publicación ha sido cancelada.");
                    [alert show];
                    break;
                case SLComposeViewControllerResultDone:
                    //NSLog(@"Se ha publicado satisfactoriamente.");
                    break;
                default:
                    break;
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        // ponemos un texto inicial para la publicación
        [twitter setInitialText:@"Aprende, enseña o intercambia tus conocimientos con iNeedClass, #iNeedClass"];
        
        // añadimos una imagen a nuestra publicación
        [twitter addImage:[UIImage imageNamed:@"fondo.png"]];
        
        // añadimos también una URL
        [twitter addURL:[NSURL URLWithString:@"https://itunes.apple.com/es/app/ineedclass/id639617478?mt=8"]];
        
        // asignamos el completionHandler para manipular los resultados del envío
        [twitter setCompletionHandler:completionHandler];
        
        // por último mostramos la interfaz de publicación
        [self presentViewController:twitter animated:YES completion:nil];
    }
}

- (void)publicarEnFacebook {
    SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"UPS" message:@"Parece ser que no tienes configurada la cuenta de Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result)
        {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    //NSLog(@"La publicación ha sido cancelada.");
                    [alert show];
                    break;
                case SLComposeViewControllerResultDone:
                    //NSLog(@"Se ha publicado satisfactoriamente.");
                    break;
                default:
                    break;
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        [facebook setInitialText:@"Aprende, enseña o intercambia tus conocimientos con iNeedClass, #iNeedClass"];
        [facebook addImage:[UIImage imageNamed:@"fondo.png"]];
        [facebook addURL:[NSURL URLWithString:@"https://itunes.apple.com/es/app/ineedclass/id639617478?mt=8"]];
        [facebook setCompletionHandler:completionHandler];
        
        [self presentViewController:facebook animated:YES completion:nil];
    }

}
- (NSArray *)leerConsultaMysql:(int)opcion texto:(NSString *)string{
    NSURL *url;
    
    if(opcion==1){
        url = [NSURL URLWithString:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=1"];
    }
    if (opcion==2) {
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=2&texto=%@", string];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    if(opcion==6){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=6&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
        
    }
    if(opcion==9){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=9&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];

    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==1){
            rows = [dict objectForKey:@"provincias"];
        }
        if(opcion==2){
            rows = [dict objectForKey:@"poblaciones"];
        }
        if(opcion==6){
            rows = [dict objectForKey:@"tipos"];
        }
        if(opcion==9){
            rows = [dict objectForKey:@"datosmateria"];
        }
        
        
    }
    return rows;
}

- (NSArray *)leerConsultaMysql2:(int)opcion texto:(NSString *)string texto2:(NSString *)string2{
    
    NSURL *url;
    
    if(opcion==3){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=3&texto1=%@&texto2=%@", string, string2];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==4){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=4&texto1=%@&texto2=%@", string, string2];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
         
    }
    if(opcion==5){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=5&texto1=%@&texto2=%@", string, string2];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
        
    }
    if(opcion==7){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=7&texto1=%@&texto2=%@", string, string2];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
        
    }
    if(opcion==8){
        NSString *url2=[NSString stringWithFormat:@"http://s425938729.mialojamiento.es/webs/inc/consulta.php?opcion=8&texto1=%@&texto2=%@", string, string2];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
        
    }
    
    
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    

    if(dict){
        if(opcion==3){
            rows = [dict objectForKey:@"materias"];
        }
        if(opcion==4){
            rows = [dict objectForKey:@"profesores"];
        }
        if(opcion==5){
            rows = [dict objectForKey:@"usuario"];
        }
        if(opcion==7){
            rows = [dict objectForKey:@"intercambios"];
        }
        if(opcion==8){
            rows = [dict objectForKey:@"datos"];
        }
        
    }
    return rows;
}



@end
