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
    var time = (blue:3, yellow:3, red:3, clossLoad:3)
    let limit = 0
    
    
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
        if time.blue > limit {
            time.blue -= 1
            print("青信号は残り\(time.blue)秒です")
        }
        
        // 青色の信号のカウントが0になったとき、黄色がカウントダウンされる
        if time.blue == limit, time.yellow > limit {
            time.yellow -= 1
            print("黄信号は残り\(time.yellow)秒です")
        }
        
        //黄信号が0になった時、赤信号がカウントダウン開始
        if time.yellow == limit, time.red > limit {
            time.red -= 1
            print("赤信号は残り\(time.red)秒です")
        }
        
        //赤信号になった時、交差道路の信号が変わる
        if time.red == limit, time.clossLoad > limit {
            time.clossLoad -= 1
            print("次の青信号まであと\(time.clossLoad)秒です")
        }
        
        if time.clossLoad == limit {
            timer?.invalidate()
        }
    }
    
    //歩行者が押しボタンを押した際に対面信号が青もしくは黄色だった場合、そのカウントを0にして対面信号を赤表示に。そして歩行者用の信号機を青にする
    func pushButton() {
        if time.blue > 0 || time.yellow > 0 {
            time.blue = limit
            time.yellow = limit
            time.clossLoad -= 1
            print("歩行者がボタンを押したため赤になりました。次の青信号まで\(time.clossLoad)秒です")
        }
    }
}
let lightTime = trafficLightTime()
lightTime.pushButton()
lightTime.start()

