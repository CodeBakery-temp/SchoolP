#import <Foundation/Foundation.h>
#import "Admin.h"
#import "Student.h"
#import "StudentService.h"
#import "DBService.h"
#import "LoginService.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        NSLog(@"___________START");
        
        /*
        //////TO GET ONE USER FROM LOGIN START//////
        DBService* db = [DBService createDatabase]; 
        
        NSMutableDictionary* usersInADic = [NSMutableDictionary dictionaryWithDictionary:[db getUsers]];
        
        LoginService* userLogin = [LoginService withUserDictionary:usersInADic];
        Student* user = [userLogin checkLogin:usersInADic];
        NSLog(@"User object gotten from login service to main and thus logged: \n %@", user);
        //////TO GET ONE USER FROM LOGIN STOP//////
        */
        

        /*
        // Databas anrop
        DBService* db = [DBService database];
        ScheduleService* schedule = [ScheduleService schedule];
        
        NSDictionary* users = [db getUsers];
        NSArray* lectures = [db getLectures];
        
        Student* student;
        for(Student* user in [users objectForKey:@"STUDENT"]) {
            student = user;
            break;
        }
        //NSLog(@"%@ \n%@ \n%ld", student, lectures, currentWeek);
        NSArray* weekLectures = [schedule getLecturesOfWeek:student lectures:lectures currentWeek:currentWeek];
        
        NSLog(@"LECTURES. %@", weekLectures);
        NSDictionary* lecturesPerDays = [schedule getLecturesPerDays:weekLectures];
        NSLog(@"\nMONDAY\n%@ \n TUESDAY\n%@ \n WEDNESDAY\n%@ \n THURSDAY\n%@ \nFRIDAY\n%@", [lecturesPerDays objectForKey:@"MONDAY"], 
              [lecturesPerDays objectForKey:@"TUESDAY"], 
              [lecturesPerDays objectForKey:@"WEDNESDAY"],
              [lecturesPerDays objectForKey:@"THURSDAY"],
              [lecturesPerDays objectForKey:@"FRIDAY"]);
         */
        
        /*
         //dag år månad
         [[Lecture alloc] lecture];
         */
        
        /*Student *student = [Student studentWithName:@"Orvar" lastName:@"Hassling" mailAddress:@"copy@paste.nu" phoneNumber:@"0735413452"];
         
         ServiceStudent *studentMM = [ServiceStudent studentWithName:@"adad" lastName:@"fnfnfn" mailAddress:@"haha.com" phoneNumber:@"123456789"];
         
         NSLog(@"This is NSDictionary --> %@", studentMM);
         
         
         NSLog(@"%@", student);
         */
        
        /*
         // Notification
         NSString * myMessage = [NSString stringWithFormat:@"%@ %@ (phonenumer: %@), you are late! A copy was sent to you're mail: %@", studentIM.firstName, studentIM.lastName, studentIM.phoneNumber, studentIM.mailAddress];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:myMessage forKey: admin.firstName];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" object: studentIM
                                                          userInfo:dict];
         */
        
        NSLog(@"___________STOP");
        
    }
    return 0;
}

