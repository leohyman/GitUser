//
//  GitUserCell.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserCell: LZBaseTableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.white

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    //MARK:setupUI
    func setupUI() {

        //头像
        self.contentView.addSubview(self.headImageView)
        self.headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.height.equalTo(40)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        self.headImageView.setNeedsLayout()
        self.headImageView.setCornerImage()
        
        
        
        

        //名字
         self.contentView.addSubview(self.nameLab)
         self.nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.top.equalTo(self.headImageView)
            make.width.equalTo(100)
            make.height.equalTo(15)
         }
        
        //分数
        self.contentView.addSubview(self.scoreNumLab)
        self.scoreNumLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLab.snp.right).offset(5)
            make.centerY.equalTo(self.nameLab.snp.centerY)
            make.right.equalTo(-15)
            make.height.equalTo(15)
        }
        
       
        //详情
        self.contentView.addSubview(self.htmlUrlLab)
        self.htmlUrlLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLab)
            make.bottom.equalTo(self.headImageView)
            make.height.equalTo(18)
            make.width.equalTo(kScreenWidth - 60)
        }

        self.lineView.isHidden = false
    }

    override var modelObject : AnyObject?{
        didSet{

            
            let userModel = modelObject as! GitUserModel
            let url = URL(string: userModel.avatar_url ?? "")
            self.headImageView.kf.setImage(with: url, placeholder: UIImage(named: "icon_mine_team_defulat"))
            self.nameLab.text = "张三"
            self.scoreNumLab.text = "123456789"
        }

    }


    //MARK:头像
    lazy var headImageView : UIImageView = {
        let headImageView = UIImageView.init(image: UIImage(named: "icon_mine_team_defulat"))
        return headImageView
    }()


    //MARK:名字
    lazy var nameLab : UILabel = {
        let nameLab = UILabel()
        nameLab.textColor = UIColorFromHex(rgbValue: 0x353535)
        nameLab.font = ktextFont(size: 14)
        return nameLab

    }()

    //MARK:分数
    lazy var scoreNumLab : UILabel = {
        let scoreNumLab = UILabel()
           scoreNumLab.textColor = UIColorFromHex(rgbValue: 0xA7A7A7)
           scoreNumLab.font = ktextFont(size: 14)
           return scoreNumLab
    }()
    
    //MARK:连接
    lazy var htmlUrlLab : UILabel = {
        let htmlUrlLab = UILabel()
           htmlUrlLab.textColor = UIColorFromHex(rgbValue: 0xA7A7A7)
           htmlUrlLab.font = ktextFont(size: 14)
           return htmlUrlLab
    }()
    
    
    
}
