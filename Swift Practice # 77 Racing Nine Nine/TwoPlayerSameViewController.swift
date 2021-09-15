//
//  TwoPlayerSameViewController.swift
//  Swift Practice # 77 Racing Nine Nine
//
//  Created by Dogpa's MBAir M1 on 2021/9/15.
//

import UIKit

class TwoPlayerSameViewController: UIViewController {

    @IBOutlet weak var p2CarImageView: UIImageView!     //P2賽車
    @IBOutlet weak var p1CarImageView: UIImageView!     //P1賽車
    @IBOutlet var p1IntLabelCollection: [UILabel]!      //P1的顯示題目標籤outletcollection
    @IBOutlet var p1AnswerButtonCollection: [UIButton]! //P1三個按鈕outletcollection
    @IBOutlet var p2IntLabelCollection: [UILabel]!      //P2的顯示題目標籤outletcollection
    @IBOutlet var p2AnswerButtonCollection: [UIButton]! //P2三個按鈕outletcollection
    @IBOutlet weak var replayButton: UIButton!          //重玩鍵button
    @IBOutlet weak var buttonBackTOFirstPage: UIButton! //返回第一頁button
    
    //公用變數
    var randomIntOne = 0
    var randomIntTwo = 0
    
    //P1用變數
    var p1TimesAnsForRight = 0      //答對幾題
    var p1answerForRandomOne = 0    //隨機數字
    var p1answerForRandomTwo = 0    //隨機數字
    var p1answerForOMT = 0          //正確答案
    var p1answerArray:[Int] = []    //儲存三個數字Array後續設定button Title使用
    
    //P2用變數
    var p2TimesAnsForRight = 0
    var p2answerForRandomOne = 0
    var p2answerForRandomTwo = 0
    var p2answerForOMT = 0
    var p2answerArray:[Int] = []
    
    //顏色Array，讓Button隨機變色
    var buttonColor : [UIColor] = [.black, .blue, .brown , .link, .lightGray, .orange, .purple, .systemGreen, .systemPink, .systemBlue, .systemRed, .cyan, .darkGray, .red, .yellow, .systemTeal, .green ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //執行自定義Function
        transP2Side()
        makePlayerOneQuestion()
        makePlayerTwoQuestion()
        
        //print(p2answerForOMT)
        //print(p1answerForOMT)
        
        buttonBackTOFirstPage.isHidden = true   //隱藏Button
        replayButton.isHidden = true            //隱藏Button

        
    }
    
    //P2顯示畫面顛倒呈現
    func transP2Side () {
        for i in 0...p2IntLabelCollection.count - 1 {
            p2IntLabelCollection[i].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        for x in 0...p2AnswerButtonCollection.count - 1 {
            p2AnswerButtonCollection[x].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
    }
    
    //設定button標題以及隨機變色,Label顯示題目
    func setPlayerOption (buttonArray:[UIButton], labelArray:[UILabel], playArray:[Int], one:Int, two:Int) {

        buttonColor.shuffle()
        for i in 0...2 {
            buttonArray[i].backgroundColor = buttonColor[i]
            buttonArray[i].setTitle(String(playArray[i]), for: .normal)
        }
        labelArray[0].text = String(one)
        labelArray[1].text = String(two)
    }
    
    //執行P1的遊戲，產生新的題目。
    func makePlayerOneQuestion () {
        randomIntOne = Int.random(in: 1...99)
        randomIntTwo = Int.random(in: 1...99)
        p1answerForRandomOne = Int.random(in: 1...9)
        p1answerForRandomTwo = Int.random(in: 1...9)
        p1answerForOMT = p1answerForRandomOne * p1answerForRandomTwo
        p1answerArray = [p1answerForOMT, randomIntOne, randomIntTwo]
        p1answerArray.shuffle()
        setPlayerOption(buttonArray: p1AnswerButtonCollection, labelArray: p1IntLabelCollection, playArray: p1answerArray,one: p1answerForRandomOne, two: p1answerForRandomTwo)
    }
    
    //執行P2的遊戲，產生新的題目。
    func makePlayerTwoQuestion () {
        randomIntOne = Int.random(in: 1...99)
        randomIntTwo = Int.random(in: 1...99)
        p2answerForRandomOne = Int.random(in: 1...9)
        p2answerForRandomTwo = Int.random(in: 1...9)
        p2answerForOMT = p2answerForRandomOne * p2answerForRandomTwo
        p2answerArray = [p2answerForOMT, randomIntOne, randomIntTwo]
        p2answerArray.shuffle()
        setPlayerOption(buttonArray: p2AnswerButtonCollection, labelArray: p2IntLabelCollection, playArray: p2answerArray,one: p2answerForRandomOne, two: p2answerForRandomTwo)
    }
    
    
    //讓全體的Button變成問號無法猜題。
    func setButtonToQuestion () {
        for i in 0...2 {
            p1AnswerButtonCollection[i].setTitle("???", for: .normal)
            p2AnswerButtonCollection[i].setTitle("???", for: .normal)
        }
    }
    
    //警告視窗
    func alertWaringString (titleString: String, messageString: String, actionString: String) {
        let alertController = UIAlertController(title: titleString , message: messageString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionString, style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
     
    //P1玩家遊戲區域
    @IBAction func p1chooseAnswer(_ sender: UIButton) {
        
        //確認是否選到正確答案，若是才對題數+1並移動車子圖片
        if sender.currentTitle == String(p1answerForOMT) {
            p1TimesAnsForRight += 1
            p1CarImageView.frame.origin.x += 55
            }
            
        //print(p1TimesAnsForRight)
        
        makePlayerOneQuestion() //產生下一道題目
        
        //若是猜對題數到達10表示遊戲結束
        if p1TimesAnsForRight == 10 {
            
            alertWaringString(titleString: "P1獲勝", messageString: "數學小天才", actionString: "恭喜") //跳警告
            setButtonToQuestion()                                                                    //產生問號
            buttonBackTOFirstPage.isHidden = false                                                   //顯示button
            replayButton.isHidden = false                                                            //顯示button
        }
        
    }
    
    //P2玩家遊戲區域
    @IBAction func p2ChooseAnswer(_ sender: UIButton) {
        
        if sender.currentTitle == String(p2answerForOMT) {
            p2TimesAnsForRight += 1
            p2CarImageView.frame.origin.x += 55
            }
            
        //print(p2TimesAnsForRight)
        makePlayerTwoQuestion()
        
        if p2TimesAnsForRight == 10 {
            alertWaringString(titleString: "P2獲勝", messageString: "數學小天才", actionString: "恭喜")
            setButtonToQuestion()
            buttonBackTOFirstPage.isHidden = false
            replayButton.isHidden = false
        }
    }
    
    

    //重玩按鈕重設所有變數並執行新題目，車子照片回到原位置
    @IBAction func playAgain(_ sender: Any) {
        p1TimesAnsForRight = 0
        p2TimesAnsForRight = 0
        randomIntOne = 0
        randomIntTwo = 0
       
        p1answerForRandomOne = 0
        p1answerForRandomTwo = 0
        p1answerForOMT = 0
        p1answerArray = []
        
        p2answerForRandomOne = 0
        p2answerForRandomTwo = 0
        p2answerForOMT = 0
        p2answerArray = []
        
        makePlayerOneQuestion()
        makePlayerTwoQuestion()
        buttonBackTOFirstPage.isHidden = true
        replayButton.isHidden = true
        p1CarImageView.frame.origin.x = 94
        p2CarImageView.frame.origin.x = 94
        
    }
    
    
    
    //返回上一頁
    @IBAction func backToFirstView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
