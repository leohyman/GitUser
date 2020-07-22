//
//  GitUserCell.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserCell: LZBaseTableViewCell {

    
//    verride init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        self.backgroundColor = UIColor.white
//
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//    //MARK:setupUI
//    func setupUI() {
//
//        self.contentView.addSubview(self.headImageView)
//        self.headImageView.snp.makeConstraints { (make) in
//            make.left.equalTo(45)
//            make.width.height.equalTo(35)
//            make.centerY.equalTo(self.contentView.snp.centerY)
//        }
//        self.headImageView.clipRectCorner(direction: .allCorners, cornerRadius: 35/2.0)
//
//
//        self.contentView.addSubview(self.nameLab)
//        self.nameLab.snp.makeConstraints { (make) in
//            make.left.equalTo(self.headImageView.snp.right).offset(10)
//            make.top.equalTo(15)
//            make.right.equalTo(-15)
//            make.height.equalTo(15)
//        }
//
//
//        self.contentView.addSubview(self.phoneNumLab)
//        self.phoneNumLab.snp.makeConstraints { (make) in
//            make.left.equalTo(self.nameLab)
//            make.top.equalTo(self.nameLab.snp.bottom).offset(3)
//            make.right.equalTo(-15)
//            make.height.equalTo(15)
//        }
//
//        self.lineView.snp.remakeConstraints { (make) in
//            make.left.equalTo(45)
//            make.bottom.equalTo(-0.5)
//            make.height.equalTo(0.5)
//            make.width.equalTo(kScreenWidth-60)
//        }
//        self.lineView.isHidden = false
//
//    }
//
//    var modelObject : AnyObject?{
//        didSet{
//
//            let url = URL(string: "http://tupian.qqjay.com/tou2/2019/0924/23c6f6ebb3b5a52afd05fa1c5b3a01e9.jpg")
//            self.headImageView.kf.setImage(with: url, placeholder: UIImage(named: "icon_mine_team_defulat"))
//            self.nameLab.text = "张三"
//            self.phoneNumLab.text = "123456789"
//        }
//
//    }
//
//
//    //MARK:头像
//    lazy var headImageView : UIImageView = {
//        let headImageView = UIImageView.init(image: UIImage(named: "icon_mine_team_defulat"))
//        return headImageView
//    }()
//
//
//    //MARK:名字
//    lazy var nameLab : UILabel = {
//        let nameLab = UILabel()
//        nameLab.textColor = UIColorFromHex(rgbValue: 0x353535)
//        nameLab.font = ktextFont(size: 14)
//        return nameLab
//
//    }()
//
//    //MARK:手机号
//    lazy var phoneNumLab : UILabel = {
//        let phoneNumLab = UILabel()
//           phoneNumLab.textColor = UIColorFromHex(rgbValue: 0xA7A7A7)
//           phoneNumLab.font = ktextFont(size: 11)
//           return phoneNumLab
//    }()
    
    
    
}
