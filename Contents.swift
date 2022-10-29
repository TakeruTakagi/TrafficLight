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
    var blueTime = 9
    var yellowTime = 3
    var redTime = 5
    
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
        while blueTime >= 0 {
            print("青になりました。残り\(blueTime)秒")
            blueTime -= 1
        }
        
        while yellowTime >= 0 {
            print("黄色になりました。残り\(yellowTime)秒")
            yellowTime -= 1
        }
        
        while redTime >= 0 {
            print("赤になりました。残り\(redTime)秒")
            redTime -= 1
        }
        
        if redTime == 0 {
            
        }
    }
}
    
    let alarm = trafficLightTime()
    alarm.start()
