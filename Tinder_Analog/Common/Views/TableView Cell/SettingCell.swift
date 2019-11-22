//
//  SettingCell.swift
//  Tinder_Analog
//
//  Created by Vitaly on 30.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import TableKit

class SettingCell: UITableViewCell, ConfigurableCell {

    
    // MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with data: Data) {
        textField.placeholder = data.placeholderText
    }
}

extension SettingCell {
    struct Data {
        let placeholderText: String?
        init(textFieldPlaceholder: String) {
            self.placeholderText = textFieldPlaceholder
        }
    }
}
