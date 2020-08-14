
//
//  TableViewCell.swift
//  inAppPaymentTutorial
//
//  Created by Dustin on 2020/08/14.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    let button : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .red
        return bt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(button)
        button.anchor(top:self.topAnchor,left: self.leftAnchor,paddingTop: 10,paddingLeft: 10, width: 20,height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
