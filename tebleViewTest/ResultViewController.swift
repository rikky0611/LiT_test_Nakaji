//
//  ResultViewController.swift
//  tebleViewTest
//
//  Created by yuki takei on 2016/01/12.
//  Copyright © 2016年 yuki takei. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //アウトレット接続パーツ
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    var topicDict : NSDictionary!   //[title : [topic],,,]
    var topicArray : [String] = []
    
    //新しく追加するトピック
    var newText:String!
    
    //ViewControllerから渡ってきた画像とタイトル
    var getImage:UIImage!
    var getText:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //タイトルと画像設定
        titleLabel.text = getText
        titleLabel.textColor = UIColor.blueColor()
        mainImageView.image = getImage
        
        //tableView設定
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //tableViewのセルの高さを動的に変更
        self.myTableView.estimatedRowHeight = 90
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        //textField設定
        textField.delegate = self
        
        //appDelegateから取得
        topicDict = appDelegate.topicDict
        if let arr = appDelegate.topicDict[getText] {
            topicArray = arr as! [String]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    // セルの設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:TableViewCell2 = myTableView.dequeueReusableCellWithIdentifier("SampleCell2", forIndexPath: indexPath) as! TableViewCell2
        
        cell.cellLabel.text = "\(topicArray[indexPath.row])"
        return cell
    }
    
    /*----------ここが呼ばれないバグ-------------*/
    //タップされたセル感知：遷移への準備
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        newText = topicArray[indexPath.row]
        // resultViewController へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("toResultVC2",sender: nil)
        
    }
    
    
    @IBAction func moji() {
        if textField.text != "" {
            topicArray.append(textField.text!)
            print("\(topicDict)")
            self.myTableView.reloadData()
            textField.text = ""
            textField.placeholder = "メッセージ"
        } else {
            textField.placeholder = "文字を記入してください"
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultVC2") {
            let resultVC2: NakamiViewController = segue.destinationViewController  as! NakamiViewController
            // SubViewController のselectedImgに選択された画像を設定する
            resultVC2.getTextMessage = newText
            
            NSLog("\(newText) was sent to Nakami" )
        }
        
    }

}
