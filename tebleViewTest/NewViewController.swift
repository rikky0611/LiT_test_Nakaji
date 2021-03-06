//
//  NewViewController.swift
//  tebleViewTest
//
//  Created by Tsubasa NAKAJIMA on H28/02/03.
//  Copyright © 平成28年 yuki takei. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //新規保存用ImageView
    @IBOutlet weak var mainImageView: UIImageView!
    //新規保存用TextView
    @IBOutlet var textField: UITextField!
    
    
    var newImage : UIImage!
    var newText : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("HomeViewControllerのviewDidAppearが呼ばれた")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeViewControllerのviewWillDisappearが呼ばれた")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    
    
    func precentPickerController(sourceType:UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.presentViewController(picker, animated:true, completion:nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        newImage = image
        mainImageView.image = image
    }
    
    @IBAction func selectButtonTapped(sender: UIButton){
        //選択肢の上に表示するアラート
        let alert = UIAlertController(title: "画像の取得先を選択",message: nil, preferredStyle: .ActionSheet)
        //選択肢設定
        let firstAction = UIAlertAction(title: "カメラ", style: .Default){
            action in
            self.precentPickerController(.Camera)
        }
        let secondAction = UIAlertAction(title: "アルバム", style: .Default){
            action in
            self.precentPickerController(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Default,handler : nil)
        
        //選択肢をアラートに登録
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(cancelAction)
        
        //アラートを表示
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //キーボードreturn時に閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func tasu() {
        print ("tasuが呼ばれた！")
        if textField.text != "" && newImage != nil {
            setAlert("保存しました",bool: true)
        } else {
            setAlert("タイトルと画像を選んでください",bool: false)
        }
    }

    //アラート設定
    func setAlert(message:String,bool:Bool){
        let alert:UIAlertController = UIAlertController(title: "タイトル", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            // ボタンが押された時の処理
            print ("pushed")
            if bool {
                self.newText = self.textField.text
                self.appDelegate.imgArray.append(self.newImage)
                self.appDelegate.myItems.append(self.newText)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            
        }))
        self.presentViewController(alert, animated: true, completion: {
            // 表示完了時の処理
            print("finished")
        })
    }
    
    
}
