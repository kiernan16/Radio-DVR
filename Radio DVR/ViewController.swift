//
//  ViewController.swift
//  Radio DVR
//
//  Created by Matthew Kiernan on 5/7/17.
//  Copyright © 2017 Matt Kiernan. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var audioPlayerView: UIView!
    
   // var player = AVAudioPlayer()
    var player = AVPlayer()
    let avpController = AVPlayerViewController()
    var currentItem: AVPlayerItem!
    
    var episodeDay = ""
    
    @IBOutlet weak var daySelector: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch daySelector.selectedSegmentIndex {
        case 0:
            episodeDay = "monday"
            break
        case 1:
            episodeDay = "tuesday"
            break
        case 2:
            episodeDay = "wednesday"
            break
        case 3:
            episodeDay = "thursday"
            break
        case 4:
            episodeDay = "friday"
            break
            
        default:
            break
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        daySelector.selectedSegmentIndex = UISegmentedControlNoSegment
        downloadMP3(day: Calendar.current.component(.weekday, from: Date()))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func downloadMP3(day: Int) {
        var dayOfWeek = ""
        
        switch day {
        case 2:
            dayOfWeek = "monday"
            break
        case 3:
            dayOfWeek = "tuesday"
            break
        case 4:
            dayOfWeek = "wednesday"
            break
        case 5:
            dayOfWeek = "thursday"
            break
        case 6:
            dayOfWeek = "friday"
            break
        default:
            dayOfWeek = "x"
        }
        
         if let audioUrl = URL(string: "192.168.1.140/radio/redeye/\(dayOfWeek).mp3") {
//                   if let audioUrl = URL(string: "http://192.168.1.140/radio/redeye/sunday.mp3") {
//        if let audioUrl = URL(string: "http://10.23.75.214/\(dayOfWeek).mp3") {
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
    
    @IBAction func deleteMP3Button(_ sender: UIButton) {
        deleteMP3()
    }
    
    func deleteMP3(){
        let fileManager = FileManager.default
        let episodePath = (self.getDirectoryPath() as NSString).appendingPathComponent("\(episodeDay).mp3")
        if fileManager.fileExists(atPath: episodePath){
            try! fileManager.removeItem(atPath: episodePath)
        }else{
            print("Something wrong.")
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func displayMP3() {
        
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("\(episodeDay).mp3")
        print("imagePAth: \(imagePAth)")
        if fileManager.fileExists(atPath: imagePAth){
            loadMP3(path: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    func manualDownload() {
        
        downloadMP3(day: (daySelector.selectedSegmentIndex + 2))
    }
    
    
    func loadMP3(path: String) {
        
        let mp3URL = NSURL(string: "file://\(path)")
        
        let asset = AVURLAsset.init(url: mp3URL as! URL)
        let anItem = AVPlayerItem.init(asset: asset)
        
        player = AVPlayer.init(playerItem: anItem)
        
//        player = AVPlayer(url: mp3URL! as URL)
        
            avpController.player = player
            avpController.view.frame = audioPlayerView.frame
            self.addChildViewController(avpController)
            self.view.addSubview(avpController.view)
            
            currentItem = player.currentItem!
        
//        do {
//            //var error: NSError
//            player = try AVAudioPlayer(contentsOf: mp3URL as! URL)
//            // do something with data
//            // if the call fails, the catch block is executed
//        } catch {
//            print(error)
//        }
//        
//        player.prepareToPlay()
//        player.play()
//        
//        player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
//        
        player.play()
        
    }
    
    
    @IBAction func manualLoadButton(_ sender: UIButton) {
    manualDownload()
    }
    
    @IBAction func LoadMP3Button(_ sender: UIButton) {
        
        displayMP3()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if player.rate > 0.0 {
            
            
        }
        
        if player.rate < 1.0 {
            
            
            
        }
    }
    
}


//http://stackoverflow.com/questions/34971317/swift-audio-slider-control
