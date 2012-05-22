#import "Note.h"
#import "DBService.h"
#import "Admin.h"
#import "Student.h"
#import "Lecture.h"
#import "Message.h"
#import "Menu.h"

NSString *const usersDB = @"http://you.iriscouch.com/schoolp-users/";
NSString *const lecturesDB = @"http://you.iriscouch.com/schoolp-schedules/";
NSString *const notificationsDB = @"http://you.iriscouch.com/schoolp-notifications/";
NSString *const getAll = @"_all_docs?include_docs=true";


@implementation DBService {
    
    NSMutableDictionary *users;
    NSMutableDictionary *notifications;
    NSMutableArray *lectures;
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
        notifications = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         [NSMutableArray array], @"NOTES",
                         [NSMutableArray array], @"MESSAGES", nil];
        lectures = [NSMutableArray array];
    }
    return self;
}


-(NSDictionary*)getUsers {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", usersDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
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

-(NSMutableArray*)getLectures {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", lecturesDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
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
            Lecture* lecture = [Lecture courseWithName:[dict objectForKey:@"course"] 
                                                 grade:[dict objectForKey:@"grade"]
                                               teacher:[dict objectForKey:@"teacher"] 
                                                  room:[dict objectForKey:@"room"]
                                              courseID:[dict objectForKey:@"courseID"] 
                                             startTime:[dict objectForKey:@"startTime"] 
                                              stopTime:[dict objectForKey:@"endTime"] 
                                            lunchStart:[dict objectForKey:@"lunchStart"] 
                                             lunchStop:[dict objectForKey:@"lunchStop"]
                                                  year:[dict objectForKey:@"year"]
                                            daysOfWeek:[dict objectForKey:@"daysOfWeek"]
                                                 weeks:[dict objectForKey:@"weeks"]];
            
            [lectures addObject:lecture];
        }
        return lectures;
    }
}
-(NSDictionary*)getNotifications {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", notificationsDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *noticesDic = [NSJSONSerialization 
                                           JSONObjectWithData:data 
                                           options:NSJSONReadingMutableContainers 
                                           error:NULL];
        
        noticesDic = [noticesDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in noticesDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            //NSLog(@"OBJECT: %@", [dict allKeys]);
            if([[dict objectForKey:@"type"]isEqualToString:@"note"]) {
                Note* note = [Note noteWithText:[dict objectForKey:@"text"] 
                                           week:[dict objectForKey:@"week"] 
                                            day:[dict objectForKey:@"day"] 
                                       courseID:[dict objectForKey:@"courseID"]];
                [[notifications objectForKey:@"NOTES"] addObject:note];
            }
            else if ([[dict objectForKey:@"type"]isEqualToString:@"message"]){
                Message* message = [Message messageWithSender:[dict objectForKey:@"sender"] 
                                                     receiver:[dict objectForKey:@"receiver"] 
                                                         text:[dict objectForKey:@"text"]];
                [[notifications objectForKey:@"MESSAGES"] addObject:message];
            }
        }
        return notifications;
    }
}

@end
