//
//  CoinTableViewCell.swift
//  Quilix Technical Task
//
//  Created by Евгений Агеенко on 22.07.22.
//

import UIKit

final class CoinTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    func setupWith(title: String?) {
        titleLabel.text = title
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
}
