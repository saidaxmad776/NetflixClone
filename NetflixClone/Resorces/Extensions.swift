//
//  Extensions.swift
//  NetflixClone
//
//  Created by Test on 06/09/22.
//

import Foundation


extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
