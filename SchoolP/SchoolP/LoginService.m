#import "LoginService.h"
#import "DBService.h"
#import "User.h"

@implementation LoginService {
    DBService* db;
    NSMutableDictionary* users;
}


@synthesize userLogin = _userLogin;

+(id) login
{
    return [[self alloc] initWithUsers];
}

-(id) initWithUsers
{
    if(self = [super init])
    {
        db = [DBService database];
        users = [NSMutableDictionary dictionaryWithDictionary:[db getUsers]];
    }
    return self;
}

/*************************************************
 Login part to check if your a admin or a student.
 Just to make it easier to separate each other
 for different menus.
 *************************************************/
-(User*) checkLogin
{
    BOOL found = FALSE;
    BOOL state = TRUE;
    
    while (state) {
        NSLog(@"Login with your mailaddress");
        NSString *userInput;
        char userBuffer[200];
        scanf("%s", userBuffer);
        userInput = [[NSString alloc] initWithUTF8String:userBuffer];
        NSLog(@"You wrote: %@", userInput);
        
        for(NSString* list in users) {
            for(User* user in [users objectForKey:list]) {
                if ([userInput isEqualToString:[user mailAddress]]) {
                    while (state) {
                        NSLog(@"Password:");
                        NSString *userPasswordInput;
                        char userPasswordBuffer[200];
                        scanf("%s", userPasswordBuffer);
                        userPasswordInput = [[NSString alloc] initWithUTF8String:userPasswordBuffer];
                        
                        if ([userPasswordInput isEqualToString:[user password]]) {
                            if ([userPasswordInput isEqualToString:[user password]]) {
                                NSLog(@"Welcome USER %@ %@", [user firstName], [user lastName]);
                                
                                return user;
                                NSLog(@"BREAK FROM IF STATEMENT");
                                found = TRUE;
                                state = FALSE;
                                break;
                            }
                        }else {
                            NSLog(@"!!! WRONG PASSWORD!!!");   
                        }
                    }
                    break;  
                } 
            }
            if(found)
                break;
        }
    }
    NSLog(@"______________LoginService END_______________");
    return nil;
}

@end