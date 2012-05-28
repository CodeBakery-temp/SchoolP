#import "LoginService.h"
#import "User.h"

@implementation LoginService


@synthesize userLogin = _userLogin;

+(id) withUserDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithUserDictionary:dic];
}

-(id) initWithUserDictionary: (NSDictionary *) dic
{
    if(self = [super init])
    {
        NSLog(@"initialized");
    }
    return self;
}

/*************************************************
 Login part to check if your a admin or a student.
 Just to make it easier to separate each other
 for different menus.
 *************************************************/
-(User*) checkLogin: (NSDictionary *) dic
{
    BOOL state = TRUE;
    while (state) {
        
        NSLog(@"Login with your mailaddress");
        NSString *userInput;
        char userBuffer[200];
        scanf("%s", userBuffer);
        userInput = [[NSString alloc] initWithUTF8String:userBuffer];
        NSLog(@"You wrote: %@", userInput);
        // NSLog(@"%c",input);
        for (User* user in [dic valueForKey:@"STUDENT"]) {
            if ([userInput isEqualToString:[user mailAddress]]) {
                while (state) {
                    NSLog(@"Password:");
                    NSString *userPasswordInput;
                    char userPasswordBuffer[200];
                    scanf("%s", userPasswordBuffer);
                    userPasswordInput = [[NSString alloc] initWithUTF8String:userPasswordBuffer];
                    //NSLog(@"%c",input);
                    
                    if ([userPasswordInput isEqualToString:[user password]]) {
                        if ([userPasswordInput isEqualToString:[user password]]) {
                            NSLog(@"Welcome USER %@ %@", [user firstName], [user lastName]);
                            //NSLog(@"Meny gör ditt val");
                            //scanf("%s",studentBuffer);
                            
                            return user;
                            NSLog(@"BREAK FROM IF STATEMENT");
                            
                            break;
                            state = FALSE;
                        }
                    }else {
                        NSLog(@"!!! WRONG PASSWORD!!! PASSWORD:");   
                    }
                }
                
                
            break;  
            }
        }  
        for (User* user in [dic valueForKey:@"ADMIN"]) {
            if ([userInput isEqualToString:[user mailAddress]]) {
                while (state) {
                    NSLog(@"Password:");
                    NSString *userPasswordInput;
                    char userPasswordBuffer[200];
                    scanf("%s", userPasswordBuffer);
                    userPasswordInput = [[NSString alloc] initWithUTF8String:userPasswordBuffer];
                    //NSLog(@"%c",input);
                    
                    if ([userPasswordInput isEqualToString:[user password]]) {
                        if ([userPasswordInput isEqualToString:[user password]]) {
                            NSLog(@"Welcome USER %@ %@", [user firstName], [user lastName]);
                            //NSLog(@"Meny gör ditt val");
                            //scanf("%s",studentBuffer);
                            
                            return user;
                            NSLog(@"BREAK FROM IF STATEMENT");
                            
                            break;
                            state = FALSE;
                        }
                    }else {
                        NSLog(@"!!! WRONG PASSWORD!!! PASSWORD:");   
                    }
                }
                
                
                break;  
            }
        }
        NSLog(@"______________LoginService END_______________");
    }
    return nil;
}

@end