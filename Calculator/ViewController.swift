//
//  ViewController.swift
//  Talkulator
//
//  Created by Umi Syam on 10/9/15.
//  Copyright © 2015 Umi Syam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let mySpeechSynth = AVSpeechSynthesizer()
    
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    var mode:Int = 0
    
    var total:Int = 0
    var langChosen:Int = 0
    var isEdgeEquals:Bool = false
    
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func dayNightMode(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.view.backgroundColor = UIColor.whiteColor()
        case 1:
            self.view.backgroundColor = UIColor.grayColor()
        default:
            break; 
        }
    }
    
    //MARK - Data Model
    var lang = [
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]

    //MARK: - PickerView Function
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lang.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let myString = "\(lang[row].4) \(lang[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        currentLang = lang[row]
        speakThisPhrase(currentLang.3)
    }
    
    //MARK: - Speaking Function
    func speakThisPhrase(passedString: String){
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = 0.50
        myUtterance.pitchMultiplier = 1.0
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        
        mySpeechSynth.speakUtterance(myUtterance)
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Welcome message
        let welcome = AVSpeechUtterance(string: "WELCOME TO TALKULATOR. LET THE CALCULATOR DO THE TALKING")
        welcome.rate = 0.50
        welcome.pitchMultiplier = 1.0
        welcome.voice = AVSpeechSynthesisVoice(language: "en-GB")
        mySpeechSynth.speakUtterance(welcome)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func tappedNumber(sender: UIButton) {
        
        if isEdgeEquals {
            isEdgeEquals = false;
            valueString = ""
        }
        
        let str:String! = sender.titleLabel!.text
        let num:Int! = Int(str)
        if (num == 0 && total == 0)
        {
            return
        }
        if (lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
        }
        valueString = valueString.stringByAppendingString(str)
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        
        if (total == 0)
        {
            total = Int(valueString)!
        }
        
        speakThisPhrase(valueString);
        
    }
    
    //MARK: - Math Operators
    @IBAction func tappedPlus(sender: AnyObject) {
        self.setModee(1)
        speakThisPhrase("plus")
    }
    
    @IBAction func tappedMinus(sender: AnyObject) {
        self.setModee(-1)
        speakThisPhrase("minus")
    }

    @IBAction func tappedMultiply(sender: AnyObject) {
        self.setModee(2)
        speakThisPhrase("times")
    }
    
    @IBAction func tappedEquals(sender: AnyObject) {
        if (mode == 0)
        {
            return
        }
        let iNum:Int = Int(valueString)!
        if (mode == 1)
        {
            total += iNum
        }
        if (mode == -1)
        {
            total -= iNum
        }
        if (mode == 2)
        {
            total *= iNum
        }
        valueString = "\(total)"
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        mode = 0
        
        
        if (total > 100000000) {
            speakThisPhrase("dude that's way too big")
        } else {
            speakThisPhrase("equals" + valueString)
        }
        
        isEdgeEquals = true;
    }
    
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
    }
    
    //MARK: - Set Mode
    func setModee(m:Int)
    {
        if (total == 0)
        {
            return
        }
        mode = m
        lastButtonWasMode = true
        total = Int(valueString)!
    }
}

