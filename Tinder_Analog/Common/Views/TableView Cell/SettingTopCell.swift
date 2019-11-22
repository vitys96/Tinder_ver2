//
//  SettingTopCell.swift
//  Tinder_Analog
//
//  Created by Vitaly on 30.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import TableKit

class SettingTopCell: UITableViewCell, ConfigurableCell {
    
    static var defaultHeight: CGFloat? {
        return 250
    }
    
    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        [imageButton1, imageButton2, imageButton3].forEach { [weak self] button in
            button?.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        }
    }
    
    func configure(with data: Data) {
        [imageButton1, imageButton2, imageButton3].forEach { button in
            button?.titleLabel?.font = data.buttonFont
        }
        configureButtonImages(images: data.images)
        
    }
    
    private func configureButtonImages(images: [UIImage]?) {
        guard let images = images, images.count != 0 else {
            return
        }
        let buttons = [imageButton1, imageButton2, imageButton3]
        for (index, image) in images.enumerated() {
            if index >= buttons.count {
                continue
            }
            buttons[index]?.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @objc private func buttonTouched(button: UIButton) {
        TableCellAction(key: "switchValueChanged", sender: self, userInfo: ["button" : button]).invoke()
    }
}

// MARK: - UI Configuration
extension SettingTopCell {
    func configureUI() {
        self.backgroundColor = UIColor.white
        [imageButton1, imageButton2, imageButton3].forEach { (button) in
            button?.imageView?.contentMode = .scaleAspectFill
            button?.layer.cornerRadius = 8
            button?.clipsToBounds = true
        }
    }
}

extension SettingTopCell {
    struct Data {
        var buttonFont: UIFont?
        var images: [UIImage]?
        init(images: [UIImage]?, buttonFont: UIFont? = .boldSystemFont(ofSize: 20)) {
            self.images = images
            self.buttonFont = buttonFont
        }
    }
}
