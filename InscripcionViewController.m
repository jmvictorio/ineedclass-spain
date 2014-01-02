//
//  InscripcionViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 13/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "InscripcionViewController.h"

@interface InscripcionViewController (){
    NSTimer *time;
    int contador;

}

@end

@implementation InscripcionViewController
@synthesize formulario;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlAddress= @"http://inc.dotidapp.com/";
    
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    
    //Load the request in the UIWebView.
    
    [formulario loadRequest:requestObj];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activity startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity stopAnimating];
    activity.hidden=TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
