//
//  ProfesoresViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 17/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ProfesoresViewController.h"
#import "IdiomaViewController.h"
#import "ViewController.h"

@interface ProfesoresViewController (){
    NSArray *paraTabla;
    NSArray *paraUsuario;
    NSArray *paraTablaIntercambio;
    NSArray *paraUsuarioIntercambio;
    NSString *materia;
    NSString *nombreTemp;
    NSString *materiaTemp;
    NSString *tipoUsuario;
    NSString *parallamar;
    NSString *emailparamandar;
    NSString *cadenaParaCompartir;
}

@end

@implementation ProfesoresViewController
@synthesize poblacion, idioma, provincia, profesores, tipo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [vistaClases setHidden:NO];
    [vistaIntercambios setHidden:YES];
    [tableView setHidden:NO];
    [academia setHidden:YES];
    [datos setHidden:YES];
    [datosIntercambio setHidden:YES];
    
    NSArray* controllers = [NSArray arrayWithObjects:tabClasesParticulares, tabIntercambios, nil];
    tabbar.items = controllers;
    tabbar.selectedItem = [controllers objectAtIndex:0];
    
    ViewController *vistafuncional = [[ViewController alloc]init];
    parallamar=@"";
    usuarioApasar=@"";
    relacionApasar=@"";
    emailparamandar=@"";
    nombres=[[NSMutableArray alloc]init];
    identificador=[[NSMutableArray alloc]init];
    precios=[[NSMutableArray alloc]init];
    tipos=[[NSMutableArray alloc]init];
    identificadorUsuarioIntercambios=[[NSMutableArray alloc]init];
    identificadorRelacionIntercambios=[[NSMutableArray alloc]init];
    nombresIntercambio=[[NSMutableArray alloc]init];
    materiaIntercambio1=[[NSMutableArray alloc]init];
    materiaIntercambio2=[[NSMutableArray alloc]init];
        tipoUsuario=@"";
    materia=@"";
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                   
                       //do something expensive
                       paraTabla=[vistafuncional leerConsultaMysql2:4 texto:poblacion texto2:idioma];
                       paraTablaIntercambio=[vistafuncional leerConsultaMysql2:7 texto:poblacion texto2:idioma];
                       NSString *nombre=@"";
                       NSString *apellido1=@"";
                       NSString *tipotemp=@"";

                       for (int cont=0;cont<[paraTabla count];cont++) {
                           
                           tipotemp=[[paraTabla objectAtIndex:cont] objectForKey:@"idtipo"];
                           
                           nombre=[[paraTabla objectAtIndex:cont] objectForKey:@"nombre"];
                           nombre=[nombre stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           nombre=[nombre stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           apellido1=[[paraTabla objectAtIndex:cont] objectForKey:@"apellido1"];
                           apellido1=[apellido1 stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           apellido1=[apellido1 stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           
                           
                           NSString *completo=[[NSString alloc] initWithFormat:@"%@ %@", nombre, apellido1];
                           
                           [nombres addObject:completo];
                           [tipos addObject:tipotemp];
                           [identificador addObject:[[paraTabla objectAtIndex:cont] objectForKey:@"idusuario"]];
                           NSString *precio=@"";
                           if([tipotemp isEqual: @"2"]){
                               precio=[[NSString alloc] initWithFormat:@"%@", [[paraTabla objectAtIndex:cont] objectForKey:@"precio"]];
                           }else{
                               precio=[[NSString alloc] initWithFormat:@"%@ €/h", [[paraTabla objectAtIndex:cont] objectForKey:@"precio"]];
                               
                           }
                           [precios addObject:precio];
                           
                       }
                       for (int cont=0;cont<[paraTablaIntercambio count];cont++) {
                           
                           tipotemp=[[paraTablaIntercambio objectAtIndex:cont] objectForKey:@"id"];
                           
                           nombre=[[paraTablaIntercambio objectAtIndex:cont] objectForKey:@"idusuario"];
                           
                           materia=[[paraTablaIntercambio objectAtIndex:cont] objectForKey:@"nombre"];
                           materia=[materia stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           materia=[materia stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           apellido1=[[paraTablaIntercambio objectAtIndex:cont] objectForKey:@"apellido1"];
                           apellido1=[apellido1 stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           apellido1=[apellido1 stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           NSString *completo=[[NSString alloc] initWithFormat:@"%@ %@", materia, apellido1];
                           materia=completo;
                           //NSLog(@"Nombre: %@",completo);
                           [identificadorUsuarioIntercambios addObject:nombre];
                           [identificadorRelacionIntercambios addObject:tipotemp];
                           [nombresIntercambio addObject:completo];
                           
                           
                       }

                       
                   
                   //dispatch back to the main (UI) thread to stop the activity indicator
                   dispatch_async(dispatch_get_main_queue(), ^
                                  {
                                      [activity stopAnimating];
                                      activity.hidden=YES;
                                      [tableView reloadData];
                                      tabClasesParticulares.badgeValue=[[NSString alloc] initWithFormat:@"%i",[identificador count]];
                                      tabIntercambios.badgeValue=[[NSString alloc] initWithFormat:@"%i",[identificadorUsuarioIntercambios count]];

                                  });

                   
                   
                   
                   
                   
                   
                   });
    
    
    
    }
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    NSString *selectedTag=tabBar.selectedItem.title;
    
    if ([selectedTag isEqual: @"Intercambios"])
    {
        [tableView reloadData];
        
        [vistaIntercambios setHidden:NO];
        [datosIntercambio setHidden:YES];
        [leyendaIntercambio setHidden:NO];
        
        [tableView setHidden:NO];
        
        [leyenda setHidden:NO];
        [vistaClases setHidden:YES];
        [datos setHidden:YES];
        [academia setHidden:YES];
    }else{
        [tableView reloadData];
        
        [vistaIntercambios setHidden:YES];
        [datosIntercambio setHidden:YES];
        [leyendaIntercambio setHidden:NO];
        
        [tableView setHidden:NO];
        
        [leyenda setHidden:NO];
        [vistaClases setHidden:NO];
        [datos setHidden:YES];
        [academia setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TABLEVIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// Necesario para indicar el número de filas de la tabla, esto suele ir ligado al tamaño de un array de elementos a mostrar..
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *selectedTag=tabbar.selectedItem.title;
    if ([selectedTag isEqual: @"Intercambios"])
    {
        return [identificadorRelacionIntercambios count];
        
    }else
        return [identificador count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Normalmente recuperaremos del array, según la posicion de la fila..
    NSString *selectedTag=tabbar.selectedItem.title;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    if ([selectedTag isEqual: @"Intercambios"])
    {
        cell.textLabel.text = [nombresIntercambio objectAtIndex:indexPath.row];
        
        UIImage *theImage = [UIImage imageNamed:@"iconos48I.png"];
        cell.imageView.image = theImage;
        

    }else{
        NSString *nombre = [nombres objectAtIndex:indexPath.row];
        NSString *precio = [precios objectAtIndex:indexPath.row];
        // Creamos la celda (o fila).
        
        
        // Y le establecemos el texto de nuestro dato a una de las filas.
        cell.textLabel.text = nombre;
        NSString *tipotemp=[tipos objectAtIndex:indexPath.row];
        if([tipotemp isEqual:@"1"]){
            UIImage *theImage = [UIImage imageNamed:@"iconosP48.png"];
            cell.imageView.image = theImage;
            cell.detailTextLabel.text=precio;
        }else {
            UIImage *theImage = [UIImage imageNamed:@"iconos48A.png"];
            cell.imageView.image = theImage;
            
        }

    }

        
    
    // Y finalizamos devolviendo la celda
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // En este método haremos lo que creamos oportuno. Por lo general pasaremos a una vista detalle del elemento seleccionado. Haciendo uso de  UINavigationController que se puede ver en el correspondiente tutorial.
    NSString *selectedTag=tabbar.selectedItem.title;
    if ([selectedTag isEqual: @"Intercambios"])
    {
        usuarioApasar = [identificadorUsuarioIntercambios objectAtIndex:indexPath.row];
        relacionApasar = [identificadorRelacionIntercambios objectAtIndex:indexPath.row];
        nombreTemp = materia;
    }else{
        usuarioApasar = [identificador objectAtIndex:indexPath.row];
        nombreTemp = [nombres objectAtIndex:indexPath.row];
    }
    [self accionpulsar];
    
}

- (IBAction)enviarMail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Sobre su anuncio en iNeedClass";
    // Email Content
    NSString *messageBody = @"Estoy interesado en su anuncio de iNeedClass";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:emailparamandar];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)llamarIntercambios:(id)sender {
    [self llamada];
}

- (IBAction)pulsaFavoritos:(id)sender{
    
    if(tableView.hidden==YES){
        [tableView setHidden:NO];
        [imagenDeFondo setHidden:NO];
        [leyenda setHidden:NO];
        [leyendaIntercambio setHidden:NO];
        [datos setHidden:YES];
        [academia setHidden:YES];
        tableView.alpha=0.0;
        [UIView beginAnimations:@"Fade-in" context:NULL];
        [UIView setAnimationDuration:1.0];
        tableView.alpha=1.0;
        [UIView commitAnimations];
    }
    else{
        tableView.alpha=1.0;
        [UIView beginAnimations:@"Fade-out" context:NULL];
        [UIView setAnimationDuration:1.0];
        tableView.alpha=0.0;
        [UIView commitAnimations];
        [tableView setHidden:YES];
        [imagenDeFondo setHidden:YES];
        [leyenda setHidden:YES];
        [leyendaIntercambio setHidden:YES];
        
    }

}
-(void)llamada {
    NSString *marcar=[[NSString alloc]initWithFormat:@"tel:%@", parallamar];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:marcar]];
}

- (void)accionpulsar{
    ViewController *vistafuncional = [[ViewController alloc]init];
    NSString *selectedTag=tabbar.selectedItem.title;
     
     if ([selectedTag isEqual: @"Intercambios"])
     {
         paraUsuario=[vistafuncional leerConsultaMysql2:8 texto:usuarioApasar texto2:relacionApasar];
         NSArray *temporal=[vistafuncional leerConsultaMysql:9 texto:[[paraUsuario objectAtIndex:0] objectForKey:@"idmateriaintercambio2"]];
         
         materiaIntercambio=[[temporal objectAtIndex:0]objectForKey:@"nombre"];
        
     }else{
         paraUsuario=[vistafuncional leerConsultaMysql2:5 texto:usuarioApasar texto2:idioma];
     }
    
    
    NSMutableArray *datosusuario=[[NSMutableArray alloc]init];
    
    
    [self rellenaDatosUsuario:datosusuario];
    
    
}

- (void)rellenaDatosUsuario:(NSMutableArray *)datosusuario{
    
    [tableView setHidden:YES];
    
    [datosIntercambio setHidden:NO];
    [imagenDeFondo setHidden:YES];
    [leyenda setHidden:YES];
    [leyendaIntercambio setHidden:YES];
    
    NSString *selectedTag=tabbar.selectedItem.title;
    
    if ([selectedTag isEqual: @"Intercambios"])
    {
        
        NSString *temporal=[[paraUsuario objectAtIndex:0] objectForKey:@"telefono"];
        parallamar=temporal;
        if(![temporal isEqualToString:@"0"]){
            
            llamarI.hidden=NO;
        }else{
            llamarI.hidden=YES;
        }
        temporal=[[paraUsuario objectAtIndex:0] objectForKey:@"comentario"];
        temporal=[temporal stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        temporal=[temporal stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
        comentariosIntercambio.text=temporal;
        
        materiaIntercambio=[materiaIntercambio stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        materiaIntercambio=[materiaIntercambio stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
        ofertaIntercambio.text=materiaIntercambio;
        
        emailparamandar=[[paraUsuario objectAtIndex:0] objectForKey:@"mail"];
        
        temporal=[[paraUsuario objectAtIndex:0] objectForKey:@"nombre"];
        temporal=[temporal stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        temporal=[temporal stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
        demandaIntercambio.text=temporal;
        
        materiaTemp=temporal;
        
        
        
        
        
    }else{
        tipoUsuario=[[paraUsuario objectAtIndex:0] objectForKey:@"idtipo"];
        if([tipoUsuario isEqualToString:@"2"]){
            
            [datos setHidden:YES];
            [academia setHidden:NO];
            NSString *nombre=[[paraUsuario objectAtIndex:0] objectForKey:@"nombre"];
            nombre=[nombre stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            nombre=[nombre stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            
            NSString *apellido=[[paraUsuario objectAtIndex:0] objectForKey:@"apellido1"];
            apellido=[apellido stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            apellido=[apellido stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            nombreAcademia.text=[[NSString alloc] initWithFormat:@"%@ %@", nombre, apellido];
            
            emailparamandar=[[paraUsuario objectAtIndex:0] objectForKey:@"mail"];
            
            NSString *titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"telefono"];
            parallamar=titulacion;
            if(![titulacion isEqualToString:@"0"]){
                llamarA.hidden=NO;
            }else{
                llamarA.hidden=YES;
            }
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"comentario"];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            comentariosAcademia.text=titulacion;
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"precio"];
            precioAcademia.text=[[NSString alloc] initWithFormat:@"%@", titulacion];
        }else{
            [datos setHidden:NO];
            [academia setHidden:YES];
            NSString *nombre=[[paraUsuario objectAtIndex:0] objectForKey:@"nombre"];
            nombre=[nombre stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            nombre=[nombre stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            
            NSString *apellido=[[paraUsuario objectAtIndex:0] objectForKey:@"apellido1"];
            apellido=[apellido stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            apellido=[apellido stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            usuarioLabel.text=[[NSString alloc] initWithFormat:@"%@ %@", nombre, apellido];
            
            NSString *titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"cursando"];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            titulacionLabel.text=titulacion;
            
            emailparamandar=[[paraUsuario objectAtIndex:0] objectForKey:@"mail"];
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"telefono"];
            parallamar=titulacion;
            if(![titulacion isEqualToString:@"0"]){
                llamarP.hidden=NO;
            }else{
                llamarP.hidden=YES;
            }
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"comentario"];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            titulacion=[titulacion stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
            comentariosLabel.text=titulacion;
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"nivel"];
            if([tipo isEqualToString:@"1"]){
                [etiquetaNivel setHidden:NO];
                [nivelLabel setHidden:NO];
                nivelLabel.text=titulacion;
                
            }else{
                [nivelLabel setHidden:YES];
                [etiquetaNivel setHidden:YES];
            }
            
            titulacion=[[paraUsuario objectAtIndex:0] objectForKey:@"precio"];
            precioLabel.text=[[NSString alloc] initWithFormat:@"%@ €/h", titulacion];
        }
        
    }
    
    
    
    
    
}
- (IBAction)compartir:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"COMPARTIR" message:@"Comparte el anuncio!" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Twitter", @"Facebook",nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        NSString *selectedTag=tabbar.selectedItem.title;
        NSString *datosParaTweet;
        if ([selectedTag isEqual: @"Intercambios"])
        {
            datosParaTweet=[[NSString alloc] initWithFormat:@"%@ está interesado en hacer un intercambio de %@ para mas info entra en #iNeedClass",nombreTemp, materiaTemp];
        }else{
            datosParaTweet=[[NSString alloc] initWithFormat:@"%@ ha puesto un nuevo anuncio para impartir clases, para mas info entra en #iNeedClass",nombreTemp];
        }
        
        [self publicarEnTwitter:datosParaTweet];
    }
    else if (buttonIndex == 2)
    {
        NSString *selectedTag=tabbar.selectedItem.title;
        NSString *datosParaFacebook;
        if ([selectedTag isEqual: @"Intercambios"])
        {
            datosParaFacebook=[[NSString alloc] initWithFormat:@"%@ está interesado en hacer un intercambio de %@ para mas info entra en #iNeedClass",nombreTemp, materiaTemp];
        }else{
            datosParaFacebook=[[NSString alloc] initWithFormat:@"%@ ha puesto un nuevo anuncio para impartir clases, para mas info entra en #iNeedClass",nombreTemp];

        }
        
        [self publicarEnFacebook:datosParaFacebook];
    }
}


- (void)publicarEnTwitter:(NSString *)datosusuario {
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
                    [alert show];
                    break;
                case SLComposeViewControllerResultDone:
                    break;
                default:
                    break;
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        };                
        
        /////////////////////////////////////////////////////////////////////
        // ponemos un texto inicial para la publicación
        [twitter setInitialText:datosusuario];
        
        // añadimos una imagen a nuestra publicación
        [twitter addImage:[UIImage imageNamed:@"flyer.png"]];
        
        // añadimos también una URL
        [twitter addURL:[NSURL URLWithString:@"https://itunes.apple.com/es/app/ineedclass/id639617478?mt=8"]];
        
        // asignamos el completionHandler para manipular los resultados del envío
        [twitter setCompletionHandler:completionHandler];
        
        // por último mostramos la interfaz de publicación
        [self presentViewController:twitter animated:YES completion:nil];
    }
}

- (void)publicarEnFacebook:(NSString *)datosusuario {
    SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"UPS" message:@"Parece ser que no tienes configurada la cuenta de Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result)
        {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    [alert show];
                    break;
                case SLComposeViewControllerResultDone:
                    break;
                default:
                    break;
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        [facebook setInitialText:datosusuario];
        [facebook addImage:[UIImage imageNamed:@"flyer.png"]];
        [facebook addURL:[NSURL URLWithString:@"https://itunes.apple.com/es/app/ineedclass/id639617478?mt=8"]];
        [facebook setCompletionHandler:completionHandler];
        
        [self presentViewController:facebook animated:YES completion:nil];
    }
    
}

//PASAR DATOS

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"vueltaAidiomas"]) {
        IdiomaViewController *segundoView = [segue destinationViewController];
        segundoView.tipo=tipo;
        segundoView.provincia = provincia;
        segundoView.poblacion = poblacion;
    }
}

@end
