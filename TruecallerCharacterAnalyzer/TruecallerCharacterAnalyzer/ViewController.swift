//
//  ViewController.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 14.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //****** Textview Components *****
    @IBOutlet weak var xthCharacterTw: UITextView!
    @IBOutlet weak var everyXthCharacterTw: UITextView!
    @IBOutlet weak var wordCounterTw: UITextView!
    @IBOutlet var processLogTw: UITextView!
    
    //****** Activity Indicator Components *****
    @IBOutlet weak var everyXthCharacterAI: UIActivityIndicatorView!
    @IBOutlet weak var xthCharacterAI: UIActivityIndicatorView!
    @IBOutlet weak var wordCounterAI: UIActivityIndicatorView!
    
    //***** Analyzer type instances *****
    let xthCharacterAnalyzer: CharacterAnalyzer = XthCharacter()
    let everyXthCharacterAnalyzer: CharacterAnalyzer = EveryXthCharacter()
    let wordCountAnalyzer: CharacterAnalyzer = WordCounter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearContent()
    }
    
    
    /**
     Processes 3 requests simultaniously and set results which provided with callback function to textviews
     
     - parameter sender: UIButton
     
     - Returns: Void
     */
    @IBAction func analyzeBtnAction(_ sender: UIButton) {
        print(Constant.Log.InfoPrefix + "Analyze button get fired...")
        
        guard isAllJobsDone() == true else {
            print(Constant.Log.WarningPrefix + "There is at least a job that not process request result...")
            self.addProcessLog(logRecord: "analyzeButton: Please wait until all jobs are finished!")
            return
        }
        
        self.clearContent()
        self.startAllActivityIndicators()
        
        // Finds Xth character for given website
        xthCharacterAnalyzer.analyze { (model, error) in
            // model as XthCharacterModel
            
            DispatchQueue.main.async(execute: {
                
                self.xthCharacterAI.stopAnimating()

                guard error == nil else{
                    self.addProcessLog(logRecord: "xthCharacterAnalyzer: " + error!)
                    return
                }
                
                let xthCharacterModel = (model as! XthCharacterModel)
                self.xthCharacterTw.text = xthCharacterModel.xthCharacter.description
                self.addProcessLog(logRecord: "xthCharacterAnalyzer: Listed above!" )
            })
        }
        
        // Finds every Xth character for given website
        everyXthCharacterAnalyzer.analyze { (model, error) in
            // model as EveryXthCharacterModel
        
            DispatchQueue.main.async(execute: {
                
                self.everyXthCharacterAI.stopAnimating()

                guard error == nil else{
                    self.addProcessLog(logRecord: "everyXthCharacterAnalyzer: " + error!)
                    return
                }
                
                let everyXthCharacterModel = (model as! EveryXthCharacterModel)
                
                let stringRepresentation = String(
                    everyXthCharacterModel.everyXthCharacterList.map{
                        String($0)
                        }.joined(separator: "\n*******\n")
                )
                
                self.everyXthCharacterTw.text = stringRepresentation
                self.addProcessLog(logRecord: "everyXthCharacterAnalyzer: Listed above!" )

            })
        }

        //Finds words for given website and retuns count
        wordCountAnalyzer.analyze { (model, error) in
            // model as WordCounterModel

            DispatchQueue.main.async(execute: {
                
                self.wordCounterAI.stopAnimating()

                guard error == nil else{
                    self.addProcessLog(logRecord: "wordCountAnalyzer: " + error!)
                    return
                }
                
                let wordCounterModel = (model as! WordCounterModel)
                let stringRepresentation = wordCounterModel.wordList.map { $0 + ":" + String($1) }.joined(separator: "\n*******\n")
                self.wordCounterTw.text = stringRepresentation
                self.addProcessLog(logRecord: "wordCountAnalyzer: Listed above!" )
            })
        }
        
    }
    
    /**
     Starts all activity indicator on UI for simultanious requests
     - Returns: Void
     */
    private func startAllActivityIndicators(){
        xthCharacterAI.startAnimating()
        everyXthCharacterAI.startAnimating()
        wordCounterAI.startAnimating()
    }
    
    
    /**
     Clears textview inputs
     - Returns: Void
     */
    private func clearContent(){
        xthCharacterTw.text = ""
        everyXthCharacterTw.text = ""
        wordCounterTw.text = ""
        processLogTw.text = ""
    }
    
    /**
     Add record to process log textview
     
     - parameter logRecord:String
     
     - Returns: Void
     */
    private func addProcessLog(logRecord: String){
        processLogTw.text?.append(logRecord + "\n")
    }
    
    
    /**
     Checks if all requests are finished
     
     - Returns: Bool
     */
    private func isAllJobsDone() -> Bool{
        return (!xthCharacterAI.isAnimating && !everyXthCharacterAI.isAnimating && !wordCounterAI.isAnimating)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

