//
//  Utilities.swift
//  scavExplorerFirebaseEx
//
//  Created by Jacob Huffman on 3/15/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import Foundation
import UIKit

class Utilities
{
    //MARK: - Password validation when signing up
    static func isPasswordValid(_ password : String) -> Bool{
    
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func getEvents(_ dateToday : String, dateTomorrow : String) -> Array<Any> {
        
        
        //MARK: - Variables
        var today = dateToday
        var tomorrow = dateTomorrow
        var allEvents = [Any]()
        
        //MARK: -LCSC calendar url's
        var entertainmentURL = "https://www.googleapis.com/calendar/v3/calendars/m6h2d5afcjfnmaj8qr7o96q89c@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        var academicsURL = "https://www.googleapis.com/calendar/v3/calendars/0rn5mgclnhc7htmh0ht0cc5pgk@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        var athleticsURL = "https://www.googleapis.com/calendar/v3/calendars/d6jbgjhudph2mpef1cguhn4g9g@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        var studentActivitiesURL = "https://www.googleapis.com/calendar/v3/calendars/l9qpkh5gb7dhjqv8nm0mn098fk@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        var resLifeURL = "https://www.googleapis.com/calendar/v3/calendars/gqv0n6j15pppdh0t8adgc1n1ts@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        var campusRecURL = "https://www.googleapis.com/calendar/v3/calendars/h4j413d3q0uftb2crk0t92jjlc@group.calendar.google.com/events?T00:00:00-07:00&timeMin=T00:00:00Z&timeMax=T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        //MARK: -End Of Variables
        let dateFormatter = DateFormatter()
        
        //format today and tomorrow date to match google
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        today = dateFormatter.dateFormat
        tomorrow = dateFormatter.dateFormat
        
        //MARK: - URL Update
        //Update ulr to get events between today and tomorrow
        entertainmentURL = "https://www.googleapis.com/calendar/v3/calendars/m6h2d5afcjfnmaj8qr7o96q89c@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        academicsURL = "https://www.googleapis.com/calendar/v3/calendars/0rn5mgclnhc7htmh0ht0cc5pgk@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        athleticsURL = "https://www.googleapis.com/calendar/v3/calendars/d6jbgjhudph2mpef1cguhn4g9g@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        studentActivitiesURL = "https://www.googleapis.com/calendar/v3/calendars/l9qpkh5gb7dhjqv8nm0mn098fk@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        resLifeURL = "https://www.googleapis.com/calendar/v3/calendars/gqv0n6j15pppdh0t8adgc1n1ts@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        campusRecURL = "https://www.googleapis.com/calendar/v3/calendars/h4j413d3q0uftb2crk0t92jjlc@group.calendar.google.com/events?T00:00:00-07:00&timeMin=" + today + "T00:00:00Z&timeMax=" + tomorrow + "T00:00:00Z&maxResults=2500&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"
        
        //pull json data
        
        //MARK: - Convert URL to be used
        let urlString1 = entertainmentURL
        let urlString2 = academicsURL
        let urlString3 = athleticsURL
        let urlString4 = studentActivitiesURL
        let urlString5 = resLifeURL
        let urlString6 = campusRecURL
        
        let url1 = URL(string: urlString1)
        let url2 = URL(string: urlString2)
        let url3 = URL(string: urlString3)
        let url4 = URL(string: urlString4)
        let url5 = URL(string: urlString5)
        let url6 = URL(string: urlString6)
        
  //MARK: - Get entertainment events
        let session1 = URLSession.shared
        
        let dataTask1 = session1.dataTask(with: url1!) { (json_data1, response, error) in
            
            //check for errors
            if error == nil && json_data1 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let entertain = try decoder.decode(Event.self, from: json_data1!)
                    
                    allEvents.append(entertain)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Get academic events
        let session2 = URLSession.shared
        
        let dataTask2 = session2.dataTask(with: url2!) { (json_data2, response, error) in
            
            //check for errors
            if error == nil && json_data2 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let academic = try decoder.decode(Event.self, from: json_data2!)
                    
                    allEvents.append(academic)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Get athletic events
        let session3 = URLSession.shared
        
        let dataTask3 = session3.dataTask(with: url3!) { (json_data3, response, error) in
            
            //check for errors
            if error == nil && json_data3 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let athletic = try decoder.decode(Event.self, from: json_data3!)
                    
                    allEvents.append(athletic)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Get student activity events
        let session4 = URLSession.shared
        
        let dataTask4 = session4.dataTask(with: url4!) { (json_data4, response, error) in
            
            //check for errors
            if error == nil && json_data4 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let studentAct = try decoder.decode(Event.self, from: json_data4!)
                    
                    allEvents.append(studentAct)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Get residence life events
        let session5 = URLSession.shared
        
        let dataTask5 = session5.dataTask(with: url5!) { (json_data5, response, error) in
            
            //check for errors
            if error == nil && json_data5 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let reslife = try decoder.decode(Event.self, from: json_data5!)
                    
                    allEvents.append(reslife)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Get campus recreation events
        let session6 = URLSession.shared
        
        let dataTask6 = session6.dataTask(with: url6!) { (json_data6, response, error) in
            
            //check for errors
            if error == nil && json_data6 != nil {
                let decoder = JSONDecoder()
                
                do {
                    let campusrec = try decoder.decode(Event.self, from: json_data6!)
                    
                    allEvents.append(campusrec)
                    
                }
                catch {
                    print("Error has occured")
                }
            }
                
        }
        //MARK: - Resume calls
        dataTask1.resume()
        dataTask2.resume()
        dataTask3.resume()
        dataTask4.resume()
        dataTask5.resume()
        dataTask6.resume()
        
        //MARK: - return allEvents array
        return allEvents
    }
}
