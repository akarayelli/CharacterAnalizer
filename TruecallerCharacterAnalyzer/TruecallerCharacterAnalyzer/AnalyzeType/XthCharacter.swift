//
//  XthCharacter.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class XthCharacter: CharacterAnalyzer {
    
    func analyze(completionHandler: @escaping (BaseUIModel?, String?) -> Void) {
        
        print(Constant.Log.InfoPrefix, "Will get ", Constant.Parameter.CharacterIndex, "th indexed character")
        
        NetworkManager.sharedInstance.request() { (responseType) in
            
            switch responseType{
            case .failure(let error):
                completionHandler(nil,  error.localizedDescription)
                break
                
            case .success(let source):
                let xthCharacterModel = XthCharacterUIModel(pageContent: source)
                
                if(Constant.Parameter.CharacterIndex >= source.characters.count){
                    completionHandler(nil, NSLocalizedString("ContentNotSufficient", comment: ""))
                    
                }else{
                    // Converts to String.Index and finds character in given index
                    let charIndex = source.index(source.startIndex, offsetBy: Constant.Parameter.CharacterIndex)
                    xthCharacterModel.xthCharacter = source[charIndex]
                    completionHandler(xthCharacterModel, nil)
                }
                break
            }
        }     
    }
}
