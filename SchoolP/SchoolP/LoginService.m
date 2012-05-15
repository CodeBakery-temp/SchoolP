#import "LoginService.h"
#import "Admin.h"
#import "Student.h"

@implementation LoginService


@synthesize studentLogin = _studentLogin;


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


-(Student*) checkLogin: (NSDictionary *) dic
{
    BOOL* state = TRUE;
    while (state) {
        
        NSLog(@"Mail adresss tack");
        NSString *studentInput;
        char studentBuffer[200];
        scanf("%s", studentBuffer);
        studentInput = [[NSString alloc] initWithUTF8String:studentBuffer];
        NSLog(@"you wrote: %@", studentInput);
        // NSLog(@"%c",input);
        for(Student* user in [dic objectForKey:@"STUDENT"]) {
            
            if ([studentInput isEqualToString:[user mailAddress]]) {
                NSLog(@"Welcome %@ %@", [user firstName], [user lastName]);
                //NSLog(@"Meny gör ditt val");
                //scanf("%s",studentBuffer);
                return user;
                NSLog(@"BREAK FROM IF STATEMENT");
                
                break;
                state = FALSE;
            }
        }
        
    }
    
}

@end