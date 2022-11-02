//信号機
//車両用は青、黄、赤が表示される
//歩行者用は青、赤が表示される
//対面信号は青90秒、黄3秒、赤50秒のサイクルで色の表示を変更する
//対面信号が黄から赤に変わったら、交差道路の車両用、歩行者用の各信号機が同時に赤から青に変わる

import Foundation // Timerクラスを使用するために必要なモジュール
import PlaygroundSupport // Playground上でTimerクラスを機能させるために必要なモジュール

// デフォルトだとTimerクラスを継続的に処理させることが出来ないため、フラグを変更
PlaygroundPage.current.needsIndefiniteExecution = true

enum trafficLightTipe {
    case blue
    case yellow
    case red
    
    var lightColor: Int { //信号の色の時間(Int)を返すようにしてみる？
        switch self{
            //一旦秒数を減らしておく
        case .blue:
            return 9
        case .yellow:
            return 3
        case .red:
            return 5
        }
    }
}

class trafficLight {
    var timer: Timer?
    var count = 0
    var limit = 0
    //各信号の時間を扱いやすいように配列に格納してみる
    var lightTime = [9,3,5]
    
    //今から何が必要か
    //現在、何色の信号か表示する
    //各信号機のカウウトダウンの実装
    
    func start() {
        // 任意の箇所でTimerクラスを使用して1秒毎にcountup()メソッドを実行させるタイマーをセット
        timer = Timer.scheduledTimer(
            timeInterval: 1, // タイマーの実行間隔を指定(単位はn秒)
            target: self, // ここは「self」でOK
            selector: #selector(countdown), // timeInterval毎に実行するメソッドを指定
            userInfo: nil, // ここは「nil」でOK
            repeats: true // 繰り返し処理を実行したいので「true」を指定
        )
    }
    
    // Timerクラスに設定するメソッドは「@objc」キワードを忘れずに付与する
    @objc func countdown() {
        
    }
}
let alarm = trafficLight()
alarm.start()
