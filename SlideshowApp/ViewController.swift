//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Yoshi on 2018/08/31.
//  Copyright © 2018年 yoshiyuki.oohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var timer: Timer!
    
    // 表示している画像の番号
    var dispImageNo = 0
    
    // 表示している画像の番号を元に画像を表示する
    func displayImage() {
        // 画像の名前の配列
        let imageNameArray = [
            "African lion 1080x1920.jpg",
            "vicuña 1080x1920.jpg",
            "Ural owl 1080x1920.jpg",
            ]
        
        // 画像の番号が正常な範囲を指しているかチェック
        // 範囲より下を指している場合、最後の画像を表示
        if dispImageNo < 0 {
            dispImageNo = 2
        }
        
        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > 2 {
            dispImageNo = 0
        }
        
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[dispImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let image = UIImage(named: "African lion 1080x1920.jpg")
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextImage(_ sender: Any) {
        // 表示している画像の番号を1増やす
        dispImageNo += 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    @IBAction func previousImage(_ sender: Any) {
        // 表示している画像の番号を1減らす
        dispImageNo -= 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    @objc func updateTimer(_ timer: Timer) {
        // 表示している画像の番号を1増やす
        dispImageNo += 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }

    @IBAction func startSlideshow(_ sender: Any) {
        // スライドショー再生
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            
            // ボタンの表示を停止に
            playButton.setTitle("停止", for: .normal)
            
            // 進む/戻るボタンの無効化
            nextButton.isEnabled = false
            prevButton.isEnabled = false
        } else {
            // 停止
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            
            // ボタンの表示を再生に
            playButton.setTitle("再生", for: .normal)
            
            // 進む/戻るボタンの有効化
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
    }
    
    @IBAction func onTapImage(_ sender: Any) {
        // セグエを使用して画面を遷移
        performSegue(withIdentifier:"result", sender: nil)
        
        // スライドショー再生中なら停止
        if self.timer != nil {
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            
            // ボタンの表示を再生に
            playButton.setTitle("再生", for: .normal)
            
            // 進む/戻るボタンの有効化
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.ExtendImage = imageView.image
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

