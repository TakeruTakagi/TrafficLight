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
    
    var lightColor: String {
        switch self{
        case .blue:
            return "青"
        case .yellow:
            return "黄色"
        case .red:
            return "赤"
        }
    }
}

class trafficLightTime {
    var timer: Timer?
    //カウントが負の数にならないように「UInt」で定義してみる
    var blueTime: UInt = 3
    var yellowTime:UInt = 3
    var redTime: UInt = 3
    var clossLoad: UInt = 3
    
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
        // 青信号をカウントダウン
        // 青色の信号のカウントが0より大きい時、青信号のカウントを1秒ずつ1減らす
        if blueTime > 0 {
            blueTime -= 1
            print("青信号は残り\(blueTime)秒です")
        }
        
        // 青色の信号のカウントが0になったとき、黄色がカウントダウンされる
        if blueTime == 0 {
            yellowTime -= 1
            print("黄信号は残り\(yellowTime)秒です")
        }
        
        //黄信号が0になった時、赤信号がカウントダウン開始
        if yellowTime == 0 {
            while redTime >= 0 { //なぜか「wjile」を使わないとカウントダウンしなくなった
                redTime -= 1
                print("赤信号は残り\(redTime)秒です")
            }
        }
        //赤信号になった時、交差道路の信号が変わる
        if redTime == 0 {
            clossLoad -= 1
            print("青信号まであと\(clossLoad)秒です")
        }
    }
}
let alarm = trafficLightTime()
alarm.start()
