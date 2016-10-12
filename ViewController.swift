//
//  ViewController.swift
//  SwiftSegmentPushAPP
//
//  Created by 大森太郎 on 2016/10/03.
//  Copyright © 2016年 大森太郎. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController,UITextFieldDelegate{
    
    //viewDidLoad
    var titleLabel: UILabel!
    var key: UILabel!
    var value: UILabel!
    var scroll:UIScrollView!
    let screenSize = UIScreen.mainScreen().bounds.size
    
    //getInstalation
    var keyLabel: UILabel!
    var valueField: UITextField!
    var addKeyField: UITextField!
    var addValueField: UITextField!
    var postButton: UIButton!

    //postInstallation
    var keyLabelArr: Array<UILabel> = []
    var valueLabelArr: Array<UITextField> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールの設定
        scroll = UIScrollView(frame:CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        scroll.layer.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 1000)
        self.view.addSubview(scroll)
        
        //ページタイトル
        titleLabel = UILabel(frame: CGRectMake(0,0,300,100))
        titleLabel.text = "CurrentInstallation"
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(28)
        titleLabel.layer.position = CGPoint(x:self.view.bounds.width/2,y:60)
        scroll.addSubview(titleLabel)
        
        //見出し（key）
        key = UILabel(frame:CGRect(x: 5, y: 70, width: 80, height: 40))
        key.backgroundColor = UIColor.whiteColor()
        key.textAlignment = NSTextAlignment.Center
        key.textColor = UIColor.blackColor()
        key.font = UIFont.systemFontOfSize(12)
        key.text = "key"
        self.scroll.addSubview(key)
        
        //見出し（value）
        value = UILabel(frame:CGRect(x: 90, y:70, width:self.view.frame.size.width-55, height: 40))
        value.backgroundColor = UIColor.whiteColor()
        value.textAlignment = NSTextAlignment.Center
        value.textColor = UIColor.blackColor()
        value.font = UIFont.systemFontOfSize(12)
        value.text = "value"
        self.scroll.addSubview(value)

        
        //installationの取得と表示
        getInstallation()
        
    }
    
    //Installationを取得するメソッド
        func getInstallation() {

            let installation = NCMBInstallation.currentInstallation()
        
            //ローカルのinstallationをfetchして更新
            installation.fetchInBackgroundWithBlock { (error: NSError!) -> Void in
            
                if installation != nil{
                    print("取得成功:\(installation)")
                    
                    //key取得
                    let keys = installation?.allKeys() as! Array<String>
                    
                    
                    for i in (0..<keys.count){
                        //valueの取得
                        let values = installation.objectForKey(keys[i])
                        
                        //keyを表示するLabelの生成
                        self.keyLabel = UILabel(frame:CGRect(x: 5, y: 100 + CGFloat(i)*45, width: 80, height: 40))
                        self.keyLabel.backgroundColor = UIColor.blueColor()
                        self.keyLabel.textAlignment = NSTextAlignment.Center
                        self.keyLabel.textColor = UIColor.whiteColor()
                        self.keyLabel.font = UIFont.systemFontOfSize(12)
                        self.keyLabel.text = keys[i]
                        self.scroll.addSubview(self.keyLabel)

                        
                        //valueの中身を表示するLabel生成
                        //既存のkeyはLabel,それ以外のkeyとchannelsはtextFieldで表示する
                        let checkArray:[String] = ["objectId","appVersion","badge","deviceToken","sdkVersion","timeZone","createDate","updateDate","deviceType","applicationName","acl"]
                        

                        if checkArray.indexOf(keys[i]) != nil {
                            
                            //既存keyのvalueを表示するLabelの作成
                            let valueLabel = UILabel(frame:CGRect(x: 90, y:100 + CGFloat(i)*45, width:self.view.frame.size.width-90, height: 40))
                            valueLabel.backgroundColor = UIColor.blackColor()
                            valueLabel.textAlignment = NSTextAlignment.Center
                            valueLabel.textColor = UIColor.whiteColor()
                            valueLabel.font = UIFont.systemFontOfSize(12)
                            valueLabel.text = String(values)
                            self.scroll.addSubview(valueLabel)
                            
                        } else {
                            
                            //独自keyのvalueを表示するFieldの作成
                            self.valueField = UITextField(frame:CGRect(x: 90, y:100 + CGFloat(i)*45, width:self.view.frame.size.width-90, height: 40))
                            self.valueField.borderStyle = UITextBorderStyle.RoundedRect
                            self.valueField.textAlignment = NSTextAlignment.Center
                            self.valueField.textColor = UIColor.blackColor()
                            self.valueField.font = UIFont.systemFontOfSize(12)
                            self.valueField.delegate = self
                            self.valueField.clearButtonMode = UITextFieldViewMode.WhileEditing
                    
                            //channelsの時だけ配列->文字列に変換し、textに設定する処理をする
                            if keys[i] == "channels"{
                                let array = values as? [String]
                                let text = array!.joinWithSeparator(",")
                                self.valueField.text = text
                            } else {
                                self.valueField.text = String(values)
                            }
                            
                            self.scroll.addSubview(self.valueField)
                        
                        }
                        
                        //繰り返し最終回に追加key・valueの挿入と送信ボタンの追加を行う
                        if i == (keys.count - 1) {

                            //追加keyのfield生成
                            self.addKeyField = UITextField(frame:CGRect(x:5,y:100 + CGFloat(i+1)*45, width:80,height:40))
                            self.addKeyField.textAlignment = NSTextAlignment.Center
                            self.addKeyField.borderStyle = UITextBorderStyle.RoundedRect
                            self.addKeyField.textColor = UIColor.blackColor()
                            self.addKeyField.font = UIFont.systemFontOfSize(12)
                            self.addKeyField.placeholder = "追加key"
                            self.addKeyField.delegate = self
                            self.scroll.addSubview(self.addKeyField)
                            
                            //追加valueのfield生成
                            self.addValueField = UITextField(frame:CGRect(x: 90, y:100 + CGFloat(i+1)*45, width:self.view.frame.size.width-90, height: 40))
                            self.addValueField.textAlignment = NSTextAlignment.Center
                            self.addValueField.borderStyle = UITextBorderStyle.RoundedRect
                            self.addValueField.textColor = UIColor.blackColor()
                            self.addValueField.font = UIFont.systemFontOfSize(12)
                            self.addValueField.placeholder = "追加value"
                            self.addValueField.delegate = self
                            self.scroll.addSubview(self.addValueField)
                            
                            //追加情報を送信するボタン生成
                            self.postButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:50))
                            self.postButton.backgroundColor = UIColor.blackColor()
                            self.postButton.setTitle("送信",forState:UIControlState.Normal)
                            self.postButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                            self.postButton.addTarget(self, action: "postInstallation", forControlEvents: .TouchUpInside)
                            self.postButton.layer.position = CGPoint(x:self.view.frame.size.width/2,y:180 + CGFloat(i+1)*45)
                            self.scroll.addSubview(self.postButton)
                            
                        }
                    
                    }
            }
            
        }
    }
    
    
    //入力された情報を送信するメソッド
    func postInstallation() {
        
        let installation = NCMBInstallation.currentInstallation()
        
        //追加fieldに入力があればセットし、送信する
        let newValues:String = (addValueField.text)!
        let newKey:String = (addKeyField.text)!
        if newValues != "" {
            //セット
            installation!.setObject(newValues, forKey: newKey)
        }

        //編集可能なfieldの内容をセットし、送信する
        for i in (0..<keyLabelArr.count){
            
            //channelsに入っている文字列を配列にしてからセットする
            if keyLabelArr[i].text! == "channels" {
                let channelsText:String = valueLabelArr[i].text!
                let arrayText:[String] = channelsText.componentsSeparatedByString(",")
                //セット
                installation!.setObject(arrayText, forKey: "channels")
                
            } else {
                //セット
                installation.setObject(String(valueLabelArr[i].text!), forKey: String(keyLabelArr[i].text!))
            
            }
        }
        
        installation!.saveInBackgroundWithBlock({( error: NSError!)-> Void in
            if error != nil{
                
                //installation更新失敗時の処理
                print("installation更新に失敗しました :\(error.code)")
                //アラートを出す
                let errAlert: UIAlertController = UIAlertController(title: "ERROR!", message: "installation更新に失敗しました", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default) { action in
                }
                errAlert.addAction(okAction)
                self.presentViewController(errAlert, animated: true, completion: nil)
                
            } else {
                
                //insitallation更新成功時の処理
                print("installation更新に成功しました")
            }
        })
       
       //viewの再読み込み
       loadView()
       viewDidLoad()
    }
    
    
    //textFieldを編集直後に呼ばれるdelegateメソッド
    func textFieldDidEditing(textField: UITextField){
    }
    
    
    //textField編集時、returnを押した際に呼ばれるdelegateメソッド
    func textFieldShouldReturn(textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}