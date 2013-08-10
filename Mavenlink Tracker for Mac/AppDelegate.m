//
//  AppDelegate.m
//  Mavenlink Tracker for Mac
//
//  Created by Vasken Hauri on 8/9/13.
//  Copyright (c) 2013 10up. All rights reserved.
//

#import "AppDelegate.h"
#import "AFJSONRequestOperation.h"


int second=0;
int minute=0;
BOOL started=TRUE;

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL *url = [NSURL URLWithString:@"https://api.mavenlink.com/api/v1/workspaces.json"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:url];
    
    [request setValue:@"%%%%ACCESS TOKEN GOES HERE FOR NOW%%%%%%%" forHTTPHeaderField:@"Authorization"];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *workspaces = [JSON valueForKeyPath:@"workspaces"];

        NSString *key;
        for(key in workspaces){
            NSDictionary *workspace = [workspaces objectForKey: key];
            [_project setStringValue: [NSString stringWithFormat: @"%@ %@\n", [_project stringValue], [workspace valueForKey:@"title"]]];
        }
    } failure:nil];
    
    [operation start];
}

- (IBAction)push_start:(id)sender {
    if(started){
        [_reset setTitle:@"Stop"];
        started=FALSE;
        [self tick:nil];
    }else {
        [_reset setTitle:@"Start"];
        started=TRUE;
    }
}

- (IBAction)push_reset:(id)sender {
    second=0;
    minute=0;
    [_reset setTitle:@"Start"];
    if(!started){
        started=TRUE;
    }
    [_TextTimer setStringValue:@"00 : 00"];
}

- (void) tick:(id)sender{
    if(!started){
        NSString *sec=[NSString stringWithFormat:@"%i", second];
        if(second<10){
            sec=[NSString stringWithFormat:@"0%i", second];
        }
        NSString *min=[NSString stringWithFormat:@"%i", minute];
        if(minute<10){
            min=[NSString stringWithFormat:@"0%i", minute];
        }
        NSString *time=[NSString stringWithFormat:@"%@ : %@", min, sec];
        [_TextTimer setStringValue:time];
        [self performSelector:@selector(tick:) withObject:nil afterDelay:1.0];
        second+=1;
        if(second>59){
            second=0;
            minute+=1;
        }
        
    }
}

@end
