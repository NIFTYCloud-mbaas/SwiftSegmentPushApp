# 【iOS Swift】アプリ側からプッシュ通知の設定をしよう〜グループ配信編〜

![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)の『プッシュ通知』機能を利用したサンプルプロジェクトです！
* アプリ側からプッシュ通知のグループ配信を設定することができます。
* 簡単な操作ですぐに [ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます！！

## 目次
* [ニフティクラウド mobile backendって何？？](#ニフティクラウド mobile backendって何？？)
* [プッシュ通知の仕組み](#プッシュ通知の仕組み)
* [作業の手順](#作業の手順)
* [サンプルアプリの使い方](#サンプルの使い方)
* [コードの解説](#解説)

## ニフティクラウド mobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.10.5(Yosemite)
* Xcode ver. 7.0.1
* iPhone6 ver. 8.2
 * このサンプルアプリは、実機ビルドが必要です
* Lightningケーブル

※上記内容で動作確認をしています


## プッシュ通知の仕組み
* ニフティクラウド mobile backendのプッシュ通知は、iOSが提供している通知サービスを利用しています
 * iOSの通知サービス　__APNs（Apple Push Notification Service）__

 ![画像1](/readme-img/001.png)

* 上図のように、アプリ（Xcode）・サーバー（ニフティクラウド mobile backend）・通知サービス（APNs）の間でやり取りを行うため、認証が必要になります
 * 認証に必要な鍵や証明書の作成は作業手順の「0.プッシュ通知機能使うための準備」で行います

## 作業の手順
* これから、次のような流れで作業を行います（少し長いので休憩しつつ行うことをオススメします）。

0. [プッシュ通知機能を使うための準備](https://github.com/u-sandriver/SwiftSegmentPushApp#0%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E9%80%9A%E7%9F%A5%E6%A9%9F%E8%83%BD%E3%82%92%E4%BD%BF%E3%81%86%E3%81%9F%E3%82%81%E3%81%AE%E6%BA%96%E5%82%99)
1. [ニフティクラウド mobile backendの会員登録とログイン→アプリ作成と設定](https://github.com/u-sandriver/SwiftSegmentPushApp#1-%E3%83%8B%E3%83%95%E3%83%86%E3%82%A3%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89-mobile-backend%E3%81%AE%E4%BC%9A%E5%93%A1%E7%99%BB%E9%8C%B2%E3%81%A8%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%82%A2%E3%83%97%E3%83%AA%E4%BD%9C%E6%88%90%E3%81%A8%E8%A8%AD%E5%AE%9A)
2. [GitHubからサンプルプロジェクトのダウンロード](https://github.com/u-sandriver/SwiftSegmentPushApp#2-github%E3%81%8B%E3%82%89%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AE%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89)
3. [Xcodeでアプリを起動](https://github.com/u-sandriver/SwiftSegmentPushApp#3-xcode%E3%81%A7%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E8%B5%B7%E5%8B%95)
4. [実機ビルド](https://github.com/u-sandriver/SwiftSegmentPushApp#4-%E5%AE%9F%E6%A9%9F%E3%83%93%E3%83%AB%E3%83%89)
5. [動作確認](https://github.com/u-sandriver/SwiftSegmentPushApp#5%E5%8B%95%E4%BD%9C%E7%A2%BA%E8%AA%8D)
6. [プッシュ通知を送りましょう！](https://github.com/u-sandriver/SwiftSegmentPushApp#6%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E9%80%9A%E7%9F%A5%E3%82%92%E9%80%81%E3%82%8A%E3%81%BE%E3%81%97%E3%82%87%E3%81%86)


### 0.プッシュ通知機能を使うための準備
__[【iOS】プッシュ通知の受信に必要な証明書の作り方(開発用)](https://github.com/natsumo/iOS_Certificate)__
* 上記のドキュメントをご覧の上、必要な証明書類の作成をお願いします
 * 証明書の作成には[Apple Developer Program](https://developer.apple.com/account/)の登録（有料）が必要です

![画像i002](/readme-img/i002.png)


### 1. [ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン→アプリ作成と設定
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します
　
![画像3](/readme-img/003.png)
　
* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します
　
![画像4](/readme-img/004.png)
　
* 続けてプッシュ通知の設定を行います
* ここで⑦APNs用証明書(.p12)の設定も行います

![画像5](/readme-img/005.png)
　
　

### 2. [GitHub](https://github.com/natsumo/SwiftPushApp.git)からサンプルプロジェクトのダウンロード
　
* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします

 * __[SwiftSegmentPushApp](https://github.com/u-sandriver/SwiftSegmentPushApp/archive/master.zip)__


### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「__SwiftSegmentPushdApp.xcworkspace__」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)
![画像06](/readme-img/006.png)

* 「SwiftSegmentpushApp.xcodeproj」（青い方）ではないので注意してください！

![画像08](/readme-img/008.png)


### 4. 実機ビルド
* 始めて実機ビルドをする場合は、Xcodeにアカウント（AppleID）の登録をします
 * メニューバーの「Xcode」＞「Preferences...」を選択します
 * Accounts画面が開いたら、左下の「＋」をクリックします。
 * Apple IDとPasswordを入力して、「Add」をクリックします
 　
 ![図F2.png](https://qiita-image-store.s3.amazonaws.com/0/112032/bef843be-5581-9e0f-aad2-1c05626d9e5d.png)
　
 * 追加されると、下図のようになります。追加した情報があっていればOKです
 * 確認できたら閉じます。
　
 ![図F3.png](https://qiita-image-store.s3.amazonaws.com/0/112032/89d9c25c-d4fa-4e93-a454-507c0575f9a3.png)
　
* プロジェクトをクリックして、「Build Settings」＞「Code Signing」に②開発用証明書(.cer)と⑤プロビジョニングプロファイルを設定します
　
![画像i25](/readme-img/i025.png)
　
* 「Code Signing Identity」に②開発用証明書(.cer)を設定しますが、「Provisioning Profile」に作成した⑤プロビジョニングプロファイルを設定すれば、「Code Signing Identity」の部分は「Automatic」で構いません
 * __注意__：作成した⑤プロビジョニングプロファイルは一度ダブルクリックをしておかないと、「Provisioning Profile」に設定できません。
* Bundle ID を設定します
* 「General」＞「Identity」の「Bundle Identifier」に③AppID を作成したときに入力したBundle IDに書き換えてください
　
![画像i26](/readme-img/i026.png)
　
* 設定は完了です
* lightningケーブルで④端末の登録で登録した、動作確認用iPhoneをMacにつなぎます
 * 実機ビルドが初めての場合は[こちら](http://qiita.com/natsumo/items/3f1dd0e7f5471bd4b7d9)をご覧いただき、実機ビルドの準備をお願いします
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします
* __ビルド時にエラーが発生した場合の対処方法__
 * Xcodeのバージョンが古い場合`import NCMB`にエラーが発生し、上手くSDKが読み込めないことがあります
 * その場合は[【Swift】SDKの読み込みにuse framework!が使えない場合の対処方法](http://goo.gl/Z1D0K3)をご覧いただき、別の読み込み方法をお試しください



### 5.動作確認
* インストールしたアプリを起動します
 * プッシュ通知の許可を求めるアラートが出たら、必ず許可してください！
* 起動されたらこの時点でデバイストークンが取得されます
* [ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「データストア」＞「installation」クラスを確認してみましょう！
　
![画像12](/readme-img/012.png)
　
* 端末側で起動したアプリは一度閉じておきます


### 6.__プッシュ通知を送りましょう！__
* いよいよです！実際にプッシュ通知を送ってみましょう！
* [ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「プッシュ通知」＞「＋新しいプッシュ通知」をクリックします
* プッシュ通知のフォームが開かれます
* 必要な項目を入力してプッシュ通知を作成します
　
![画像13](/readme-img/013.png)
　
* 端末を確認しましょう！
* 少し待つとプッシュ通知が届きます！！！
　


## サンプルの使い方
![画像cap1](/readme-img/cap01.png)

* 初期状態はこのような状態になっており、channelsの編集と新しいフィールドの追加ができます。


![画像cap2](/readme-img/cap02.png)
　
* channelsの編集と、新しいフィールドの追加をしてみましょう。
* channelsは`,`で区切ることで、配列として処理することができます。
* 編集が完了したら送信ボタンをタップして下さい。



![画像cap3](/readme-img/cap03.png)
　
* 追加した後、送信ボタンを押すとviewが自動でリロードされ、追加・更新が行われていることがわかります。追加したフィールドは後から編集することが可能です。
* ダッシュボードから、更新ができていることを確認してみましょう！



## 解説
サンプルプロジェクトに実装済みの内容のご紹介

#### SDKのインポートと初期設定
* ニフティクラウド mobile backend の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [SwiftでmBaaSを始めよう！(＜CocoaPods＞でuse_framewoks!を有効にした方法)](http://qiita.com/natsumo/items/57d3a4d9be16b0490965)
　

#### ロジック
 * `AppDelegate.swift`の`didFinishLaunchingWithOptions`メソッドにAPNsに対してデバイストークンの要求するコードを記述し、デバイストークンが取得された後に呼び出される`didRegisterForRemoteNotificationsWithDeviceToken`メソッドを追記をします
 * デバイストークンの要求はiOSのバージョンによってコードが異なります
　
```swift
//
//  AppDelegate.swift
//  SwiftPushApp
//
//  Created by Yuko Sunagawa on 2016/10/03.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //********** APIキーの設定 **********
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //********** SDKの初期化 **********
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        
        /// デバイストークンの要求
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
            /** iOS8以上 **/
             //通知のタイプを設定したsettingを用意
            let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
            let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
            //通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            //DevoceTokenを要求
            application.registerForRemoteNotifications()
        }else{
            /** iOS8未満 **/
            let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
        }

        return true
    }
    
    // デバイストークンが取得されたら呼び出されるメソッド
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        // 端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation = NCMBInstallation.currentInstallation()
        // デバイストークンの設定
        installation.setDeviceTokenFromData(deviceToken)
        // 端末情報をデータストアに登録
        installation.saveInBackgroundWithBlock { (error: NSError!) -> Void in
            if (error != nil){
                // 端末情報の登録に失敗した時の処理
                
            }else{
                // 端末情報の登録に成功した時の処理
                
            }
        }
    }

}
```

#### 取得ロジック

* `ViewController.swift`の`getInstallation`メソッド内でinstallationクラスを生成しています。
*  `.allkey()`で、フィールドを全件取得できます。
* `.objectForKey()`で、指定したフィールドの中身を取り出すことができます。

#### 更新ロジック
* `postInstallation`メソッド内で行います。
* `.setObject()`で更新内容とフィールド名を指定し、`.saveInBackgroundWithBlock`で更新します。
* 更新後は自動でviewのリロードが実行され、更新内容が書き換わります。


## 参考
* 同じ内容の【Objective-C】版も作成しておりますのでお待ちください。
