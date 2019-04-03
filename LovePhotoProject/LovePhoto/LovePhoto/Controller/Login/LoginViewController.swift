//
//  LoginViewController.swift
//  LovePhoto
//
//  Created by 黎应明 on 2019/4/3.
//  Copyright © 2019年 黎应明. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var QQLoginBtn: UIButton!
    @IBOutlet weak var weiXinLoginBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var getCodeLabel: UILabel!
    @IBOutlet weak var codeTextView: UITextField!
    @IBOutlet weak var phoneTextView: UITextField!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var userHeaderImage: UIImageView!
    
    deinit {
        print("LoginViewController====deinit=====")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         weak var weakSelf = self
        // 设置导航控制器的代理为self
       
        self.navigationController?.delegate = self;
        self.navigationController?.isNavigationBarHidden = true;
        backImage.whenTapped {
            weakSelf!.dismiss(animated: true, completion: nil)
        }
        //切圆角
        GetCornerRadii()
//        获取验证码
        getCodeLabel.whenTapped {
            weakSelf!.GetCode()
        }
        
    }
    
    //    MARK:切圆角方法
    func GetCornerRadii() {
        Tool.view(withImageSimple: userHeaderImage, cornerRadii: userHeaderImage.bounds.size)
        Tool.view(withImageSimple: loginBtn, cornerRadii: loginBtn.bounds.size)
        Tool.view(withImageSimple: weiXinLoginBtn, cornerRadii: weiXinLoginBtn.bounds.size)
        Tool.view(withImageSimple: QQLoginBtn, cornerRadii: QQLoginBtn.bounds.size)
    }
    //    MARK:获取验证码
    func GetCode() {
        if CanGetCode() {
            HttpHelper.getVerificationCode(byMobile: phoneTextView.text, type: "1", success: { (data) in
//                处理验证码的操作获取
            
            }) { (error) in
                Tool.showPromptContent(error)
            }
        }
    }
    
    func CanGetCode() -> Bool {
        if ( phoneTextView.text!.count < 1) {
            Tool.showPromptContent("请输入手机号", on: self.view)
            
            return false
        }
        
        if(!Tool.isMobileNumberClassification(phoneTextView.text))
        {
            Tool.showPromptContent("请输入正确手机号", on: self.view)
            
            return false
        }
        return true
    }
    
    func CanLogin() -> Bool {
        
        if CanGetCode() {
            if (codeTextView.text!.count < 1) {
                Tool.showPromptContent("请输入验证码", on: self.view)
                return false
            }
            return true
        }else{
          return false
        }
    }

    //MARK:登录
    @IBAction func loginFuncation(_ sender: Any) {
       
        if CanLogin() {
            let Hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            Hud?.labelText = "登录中..."
        }
    }
//    微信登录
    
    @IBAction func WeixinLoginFuncation(_ sender: Any) {
        
        
    }
//    QQ登录
    @IBAction func QQLoginFuncation(_ sender: Any) {
        
        
    }
}
