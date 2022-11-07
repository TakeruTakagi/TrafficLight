import Foundation // Timerクラスを使用するために必要なモジュール
import PlaygroundSupport // Playground上でTimerクラスを機能させるために必要なモジュール

// デフォルトだとTimerクラスを継続的に処理させることが出来ないため、フラグを変更
PlaygroundPage.current.needsIndefiniteExecution = true



class trafficLight {
    
    enum LightType {
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
    
    var timer: Timer?
    //カウントが負の数にならないように「UInt」で定義してみる
    var time = (blue:3, yellow:3, red:3, clossLoad:3)
    let limit = 0
    
    
    func start(lightType: LightType) {
        
        if time.blue > 0 {
            print("\(lightType.lightColor)です")
        }
        
        if time.blue == 0 && time.yellow > 0 {
            print("\(lightType.lightColor)です")
        }
        
        if time.yellow == 0 && time.red > 0 {
            print("\(lightType.lightColor)です")
        }
        
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
        
        //赤信号になった時、交差道路の信号が変わる/カウントされない。なぜ？
        if time.red == limit {
            time.clossLoad -= 1
            print("次の青信号まであと\(time.clossLoad)秒です")
        }
        
        if time.clossLoad == 0 {
            timer?.invalidate()
        }
    }
}

let lightTime = trafficLight()
lightTime.start(lightType: .blue)
