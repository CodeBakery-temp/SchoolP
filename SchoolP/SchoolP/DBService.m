#import "DBService.h"
#import "Admin.h"
#import "Student.h"
#import "StudentService.h"

NSString *const usersDB = @"http://you.iriscouch.com/schema/";
NSString *const getAll = @"_all_docs?include_docs=true";


@implementation DBService {
    
    NSMutableDictionary *users;
}


+(id)database {
    return [self createDatabase];
}
+(id)createDatabase {
    return [[self alloc] initDatabase];
}

-(id)init {
    return [self initDatabase];
}
-(id)initDatabase {
    if(self = [super init])
    {
        users = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                 [NSMutableArray array], @"ADMIN",
                 [NSMutableArray array], @"STUDENT", nil];
    }
    return self;
}


-(NSDictionary*)getAllUsers {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", usersDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *usersDic = [NSJSONSerialization 
                                         JSONObjectWithData:data 
                                         options:NSJSONReadingMutableContainers 
                                         error:NULL];
        
        usersDic = [usersDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in usersDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            //NSLog(@"OBJECT: %@", [dict allKeys]);
            if([[dict objectForKey:@"admin"]isEqualToString:@"0"]) {
                Student* user = [Student studentWithName:[dict objectForKey:@"firstName"] 
                                                lastName:[dict objectForKey:@"lastName"] 
                                             mailAddress:[dict objectForKey:@"mailAddress"] 
                                             phoneNumber:[dict objectForKey:@"phoneNumber"]
                                                 courses:[dict objectForKey:@"courses"]];
                [[users objectForKey:@"STUDENT"] addObject:user];
            }
            else {
                Admin* user = [Admin adminWithName:[dict objectForKey:@"firstName"] 
                                          lastName:[dict objectForKey:@"lastName"] 
                                       mailAddress:[dict objectForKey:@"mailAddress"]
                                       phoneNumber:[dict objectForKey:@"phoneNumber"]
                                           courses:[dict objectForKey:@"courses"]];
                [[users objectForKey:@"ADMIN"] addObject:user];
            }
        }
        return users;
    }
}

@end
