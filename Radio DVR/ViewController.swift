//
//  ViewController.swift
//  Radio DVR
//
//  Created by Matthew Kiernan on 5/7/17.
//  Copyright © 2017 Matt Kiernan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    downloadMP3(day: Calendar.current.component(.weekday, from: Date()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func downloadMP3(day: Int) {
        var dayOfWeek = ""
        
        switch day {
        case 1:
            dayOfWeek = "monday"
            break
        case 2:
            dayOfWeek = "tuesday"
            break
        case 3:
            dayOfWeek = "wednesday"
            break
        case 4:
            dayOfWeek = "thursday"
            break
        case 5:
            dayOfWeek = "friday"
            break
        default:
            dayOfWeek = "x"
        }
        
       // if let audioUrl = URL(string: "192.168.1.140/radio/redeye/\(dayOfWeek).mp3") {
            if let audioUrl = URL(string: "http://192.168.1.140/radio/redeye/sunday.mp3") {
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print("\nDestination URL: \(destinationUrl)\n")
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }
    }
    
    

}

