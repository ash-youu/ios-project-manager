//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        label.text = PlaceHolder.tableViewTitle
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 3
        label.textColor = UIColor.systemGray
        label.text = PlaceHolder.tableViewBody
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        label.text = PlaceHolder.tableViewDate
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configureContent(title: String, body: String, date: Date) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date.customDescription
        
        if date < Date() {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .black
        }
    }
}
