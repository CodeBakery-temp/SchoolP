#import <Foundation/Foundation.h>
#import "User.h"
#import "ScheduleService.h"
#import "DBService.h"
#import "LoginService.h"
#import "Lecture.h"
#import "Menu.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        NSLog(@"___________START");
        
        [Menu menu];
        
        
        
        
        
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*
        //////TO GET ONE USER FROM LOGIN START//////
        DBService* db = [DBService database];
        ScheduleService* schedule = [ScheduleService schedule];*/
        /*
        // DATE
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger units = NSWeekCalendarUnit;
        NSDateComponents *components = [calendar components:units fromDate:date];*/
         /*
        NSArray* lectures = [db getLectures];
        [schedule updateLectureEvent:@"1" version:@"2" lectures:lectures jsonPath:@"/Users/username/Desktop/lecture.json"];*/
        /* Write JSON like this
         {
         "daysOfWeek": [
         "Thursday",
         "Friday"
         ],
         "course": "Objective-C",
         "courseID": "1",
         "stopTime": "16:00",
         "grade": "YhApp",
         "lunchStart": "12:00",
         "lunchStop": "13:00",
         "startTime": "09:00",
         "weeks": [
         "21"
         ],
         "year": "2012",
         "teacher": "matssod@gmail.com",
         "room": "2010"
         }*/
        /*
        // LOGIN
        NSMutableDictionary* usersInADic = [NSMutableDictionary dictionaryWithDictionary:[db getUsers]];
        
        LoginService* userLogin = [LoginService withUserDictionary:usersInADic];
        Student* user = [userLogin checkLogin:usersInADic];
        NSLog(@"User logged in: \n %@", user);
        //////TO GET ONE USER FROM LOGIN STOP//////
        
        // GET SCHEMA
        NSArray* lectures = [db getLectures];
        NSArray* allYourLectures = [schedule getLecturesOfWeek:user lectures:lectures currentWeek:[components week]];
        NSDictionary* lecturesSorted = [schedule getLecturesPerDays:allYourLectures];
        
        // GET NOTES
        NSArray* notes = [[db getNotifications]objectForKey:@"NOTES"];
        NSArray* allYourNotes = [schedule getNotesOfWeek:user notes:notes currentWeek:[components week]];
        NSDictionary* notesSorted = [schedule getNotesPerDays:allYourNotes];
        [schedule printLecturesWithNotes:lecturesSorted notes:notesSorted];            
        
         // Notification
         NSString * myMessage = [NSString stringWithFormat:@"%@ %@ (phonenumer: %@), you are late! A copy was sent to you're mail: %@", studentIM.firstName, studentIM.lastName, studentIM.phoneNumber, studentIM.mailAddress];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:myMessage forKey: admin.firstName];
        
         
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" 
                                                            object:studentIM
                                                          userInfo:dict];
         */
        
        NSLog(@"___________STOP");
        
    }
    return 0;
}

