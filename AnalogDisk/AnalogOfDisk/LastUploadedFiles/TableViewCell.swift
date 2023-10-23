//
//  TableViewCell.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import SnapKit
import UIKit

class TableViewCell: UITableViewCell {
    
    let viewCell = UIView()
    let roundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    let headerLabel = MyLabel(type: .headerLabel, frame: CGRect())
    let sizeLabel = MyLabel(type: .textLabel, frame: CGRect())
    let dateLabel = MyLabel(type: .textLabel, frame: CGRect())
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        roundImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(roundImageView)
        viewCell.addSubview(headerLabel)
        viewCell.addSubview(sizeLabel)
        viewCell.addSubview(dateLabel)
        contentView.addSubview(viewCell)
    }
    
    private func setupConstraints() {
        viewCell.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.rightMargin).offset(-16)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        roundImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 22))
            make.left.equalTo(viewCell.snp.left)
            make.top.equalTo(viewCell.snp.top).offset(10)
        }
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(roundImageView.snp.right).offset(15)
            make.top.equalTo(viewCell.snp.top).offset(6)
        }
        sizeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(roundImageView.snp.right).offset(15)
            make.top.equalTo(headerLabel.snp.bottom).offset(2)
            make.bottom.equalTo(contentView.snp.bottom).offset(-6)
            make.width.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(sizeLabel.snp.right).offset(5)
            make.top.equalTo(sizeLabel.snp.top)
        }
    }
}

class MyLabel: UILabel {
    
    init(type: TypeLabel, frame: CGRect) {
        super.init(frame: frame)
        initializeLabel(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLabel(type: TypeLabel) {
        switch type {
        case .headerLabel:
            textColor = UIColor.black
            font = UIFont.systemFont(ofSize: 15)
        case .textLabel:
            textColor = UIColor.darkGray
            font = UIFont.systemFont(ofSize: 13)
        }
    }
    
    enum TypeLabel {
        case headerLabel
        case textLabel
    }
}

