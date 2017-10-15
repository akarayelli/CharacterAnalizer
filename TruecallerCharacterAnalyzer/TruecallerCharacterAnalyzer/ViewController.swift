//
//  ViewController.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 14.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var xthCharacterTw: UITextView!
    @IBOutlet weak var everyXthCharacterTw: UITextView!
    @IBOutlet weak var wordCounterTw: UITextView!
    
    @IBOutlet weak var everyXthCharacterAI: UIActivityIndicatorView!
    @IBOutlet weak var xthCharacterAI: UIActivityIndicatorView!
    @IBOutlet weak var wordCounterAI: UIActivityIndicatorView!
    
    let xthCharacterAnalyzer: CharacterAnalyzer = XthCharacter()
    let everyXthCharacterAnalyzer: CharacterAnalyzer = EveryXthCharacter()
    let wordCountAnalyzer: CharacterAnalyzer = WordCounter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func analyzeBtnAction(_ sender: UIButton) {
        
        self.startAllActivityIndicators()
        
        xthCharacterAnalyzer.analyze { (model, error) in
            DispatchQueue.main.async(execute: {
                guard error == nil else{
                    let alert = UIAlertController(title: NSLocalizedString("ERROR", comment: ""), message: error, preferredStyle: .actionSheet)
                    self.present(alert, animated: false, completion: nil)
                    return
                }
                
                let xthCharacterModel = (model as! XthCharacterModel)
                self.xthCharacterTw.text = xthCharacterModel.xthCharacter.description
                self.xthCharacterAI.stopAnimating()
            })
        }
        
        
        everyXthCharacterAnalyzer.analyze { (model, error) in
            DispatchQueue.main.async(execute: {
                guard error == nil else{
                    let alert = UIAlertController(title: NSLocalizedString("ERROR", comment: ""), message: error, preferredStyle: .actionSheet)
                    self.present(alert, animated: false, completion: nil)
                    return
                }
                
                let everyXthCharacterModel = (model as! EveryXthCharacterModel)
                
                let stringRepresentation = String(
                    everyXthCharacterModel.everyXthCharacterList.map{
                        String($0)
                        }.joined(separator: "\n*******\n")
                )
                
                self.everyXthCharacterTw.text = stringRepresentation
                self.everyXthCharacterAI.stopAnimating()
            })
        }
        
        
        
        wordCountAnalyzer.analyze { (model, error) in
            DispatchQueue.main.async(execute: {
                guard error == nil else{
                    let alert = UIAlertController(title: NSLocalizedString("ERROR", comment: ""), message: error, preferredStyle: .actionSheet)
                    self.present(alert, animated: false, completion: nil)
                    return
                }
                
                let wordCounterModel = (model as! WordCounterModel)
                
                let stringRepresentation = wordCounterModel.wordList.map { $0 + ":" + String($1) }.joined(separator: "\n*******\n")
                
                self.wordCounterTw.text = stringRepresentation
                self.wordCounterAI.stopAnimating()
            })
        }
        
    }
    
    private func startAllActivityIndicators(){
        xthCharacterAI.startAnimating()
        everyXthCharacterAI.startAnimating()
        wordCounterAI.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

