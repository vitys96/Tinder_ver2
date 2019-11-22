//
//  TextFieldCell.swift
//  Tinder_Analog
//
//  Created by Vitaly on 01.11.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import TableKit
import IQKeyboardManagerSwift

class TextFieldCell: UITableViewCell, ConfigurableCell {

    // MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configure(with data: Data) {
        textField.placeholder = data.placeholderText
        if let keyType = data.keybordType {
            textField.keyboardType = keyType
        }
        guard let text = data.textFieldText else { return }
        textField.text = text
        self.textField.delegate = self
        
    }
}

extension TextFieldCell {
    struct Data {
        let placeholderText: String?
        let keybordType: UIKeyboardType?
        let textFieldText: String?
        
        init(textFieldPlaceholder: String, keybordType: UIKeyboardType? = nil, textFieldText: String?) {
            self.placeholderText = textFieldPlaceholder
            self.keybordType = keybordType
            self.textFieldText = textFieldText
        }
    }
}

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
