//
//  FeedTableViewCell.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 14/08/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    var id: String?

    var spended: FeedObject? {
        willSet {
            if let spend = newValue {
                self.id = spend.id
                nameLabel.text = spend.price.isEmpty ? spend.name : "\(spend.name): R$ \(spend.price)"
                dateLabel.text = spend.dateAtString
            }
        }
    }

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
