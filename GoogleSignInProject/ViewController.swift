//
//  ViewController.swift
//  GoogleSignInProject
//
//  Created by 星みちる on 2019/08/07.
//  Copyright © 2019 星みちる. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //おまじない
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }


}

extension ViewController:GIDSignInDelegate,GIDSignInUIDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //エラーの確認をする
        if let error = error{
            //errorがnilでない場合（エラーがある場合）
            print("Google Sign Inでエラーが発生しました")
            
            //エラー情報を出してくれる
            print(error.localizedDescription)
            return
        }
        
        //Googleサインインの準備をする（トークンの取得,ユーザー情報の取得）
        //ユーザー情報取得
        let authentication = user.authentication
        
        //Googleのトークンを取得
        let credential = GoogleAuthProvider.credential(withIDToken: authentication!.idToken, accessToken: authentication!.accessToken)
        
        //Googleでログインをする、Firebaseにログイン情報を書き込む。
        Auth.auth().signIn(with: credential) { (AuthDataResult, error)
            in
            
            if let error = error {
                
                print("失敗")
                print(error.localizedDescription)
                
            }else{
                print("成功")
                
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
        
            
    }
    
    
    
}
}
