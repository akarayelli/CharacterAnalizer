//
//  CharacterAnalyzer.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

protocol CharacterAnalyzer {
    
    func analyze(completionHandler:@escaping (_ result : BaseUIModel?, _ error: String?) -> Void)

}
