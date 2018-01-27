

import UIKit

class ViewController: UIViewController {
    var drawView = UIImageView()
    
    // パーセントの円弧のパスを作る
    func arcPercent(_ radius:CGFloat, _ percent:Double) -> UIBezierPath {
        let endAngle = 2*Double.pi*percent/100 - Double.pi/2
        let path = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: 0),
            radius: radius,
            startAngle: CGFloat(-Double.pi/2),
            endAngle: CGFloat(endAngle),
            clockwise: percent>0
        )
        return path
    }
    
    func drawLine(pac: Float) -> UIImage {
        // イメージ処理の開始
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let percent = pac
        // 円弧のパスを作る
        UIColor.red.setStroke()
        let arcPath = arcPercent(80, Double(percent))
        arcPath.lineWidth = 60
        arcPath.lineCapStyle = .butt
        // パスを平行移動する
        let tf = CGAffineTransform(translationX: view.center.x, y: view.center.y)
        arcPath.apply(tf)
        arcPath.stroke()
        
        // 「何％」の数字を書く
        let font = UIFont.boldSystemFont(ofSize: 28)
        let textFontAttributes = [NSAttributedStringKey.font: font,
                                  NSAttributedStringKey.foregroundColor: UIColor.gray]
        let drawString = String(Int(percent)) + "%"
        let posX = view.center.x - 45
        let posY = view.center.y - 15
        let rect = CGRect(x: posX, y: posY, width: 90, height: 30)
        drawString.draw(in: rect, withAttributes: textFontAttributes)
        
        // イメージコンテキストからUIImageを作る
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // イメージ処理の終了
        UIGraphicsEndImageContext()
        return image!
    }
    @IBAction func slider(_ sender: UISlider) {
        drawView.removeFromSuperview()
        // 図形のイメージを作る
        let drawImage = drawLine(pac: sender.value)
        // イメージビューに設定する
        drawView = UIImageView(image: drawImage)
        // 画面に表示する
        view.addSubview(drawView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 図形のイメージを作る
        let drawImage = drawLine(pac: 1)
        // イメージビューに設定する
        drawView = UIImageView(image: drawImage)
        // 画面に表示する
        view.addSubview(drawView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

