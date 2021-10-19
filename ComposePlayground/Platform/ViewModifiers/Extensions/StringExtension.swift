//
//  StringExtension.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
