//
//  FZHTabBar.swift
//  03-FZHTabBarController(swift)
//
//  Created by 冯志浩 on 16/8/15.
//  Copyright © 2016年 FZH. All rights reserved.
//

import UIKit
protocol FZHTabBarDelegate {
    func tabbar(tabbar: FZHTabBar,formWhichItem: Int, toWhichItem: Int)
}
class FZHTabBar: UIView {
    var tabBarButtons: NSMutableArray = []
    var selectedButton = FZHTabbarButton()
    var fzhTabbarDelegate: FZHTabBarDelegate! = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
//            add plus
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTabbarButtonWith(item: UITabBarItem) -> Void {
        let button = FZHTabbarButton()
        self.tabBarButtons.addObject(button)
        button.item = item
        button.addTarget(self, action: #selector(buttonDidTouch), forControlEvents: .TouchDown)
        self.addSubview(button)
        //        默认选中
        if self.tabBarButtons.count == 1 {
            self.buttonDidTouch(button)
        }
    }
    
    func buttonDidTouch(button: FZHTabbarButton) -> Void {

        fzhTabbarDelegate.tabbar(self,formWhichItem:Int(self.selectedButton.tag), toWhichItem: Int(button.tag))
        
//        控制器选中按钮
        self.selectedButton.selected = false
        button.selected = true
        self.selectedButton = button
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        button
        let buttonW = self.frame.size.width/CGFloat(self.subviews.count)
        let buttonH = self.frame.size.height
        let buttonY = 0
        
        for index in 0...self.tabBarButtons.count - 1 {
//            取出按钮
            let button: UIButton = self.tabBarButtons[index] as! UIButton
//            2.设置按钮的frame
            let buttonX = CGFloat(index) * buttonW
            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: buttonH)
//            3.绑定tag
            button.tag = index
        }
        
    }
    
}