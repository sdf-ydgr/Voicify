//
//  RecordSoundsViewController.swift
//  voicify
//
//  Created by Sadafi Yadegari on 2016-09-12.
//  Copyright © 2016 Sadafi Yadegari. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLable: UILabel!
    
    var audioRecorder:AVAudioRecorder!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        //print("record button was pressed")
        recordingLable.text = "Recording in progress"
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try!
            session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(sender: AnyObject) {
        //print("stop recording button was pressed")
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordingLable.text = "Tap to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "stopRecording") {
//            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
//            let recordedAudioURL = sender as! NSURL
//            playSoundsVC.recordedAudioURL = recordedAudioURL
//        }
//    }
}

