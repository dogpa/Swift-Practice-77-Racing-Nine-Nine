//
//  ViewController.swift
//  Swift Practice # 77 Racing Nine Nine
//
//  Created by Dogpa's MBAir M1 on 2021/9/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startToPlayTwoPlayer(_ sender: UIButton) {
        //指派gameView為第二頁遊戲畫面twoPlayerSameGame
        //第二頁須設定StoryBoardID
        let gameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "twoPlayerSameGame")
        //跳轉到指派好的gameView 也就是第二頁遊戲畫面
        present(gameView, animated: true, completion: nil)
    }
    
}

