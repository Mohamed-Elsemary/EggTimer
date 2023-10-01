import UIKit
import AVFoundation
class ViewController: UIViewController {
    var eggTimes = ["Soft":3,"Medium":4,"Hard":720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate() // to countdown in an appropriate way while changing the needed one
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter(_:)), userInfo: ["hardness": hardness], repeats: true)
    }
    @objc func updateCounter(_ timer: Timer) {
        if secondsPassed <= totalTime {
            let precentagePassed = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = precentagePassed
            secondsPassed += 1
        }
        else{
            titleLabel.text = "DONE!"
            playSound()
            timer.invalidate() // to stop the sound after its time executed
        }
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource:"alarm_sound", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
}
}
/* if hardness == "Soft" {
 print(softTime)
 }
 else if hardness == "Medium"{
 print(mediumTime)
 }
 else {
 print(hardTime)
 }
 */
/*switch hardness {
 case "Soft":
 print(softTime)
 break
 case "Medium":
 print(mediumTime)
 break
 case "Hard":
 print(hardTime)
 break
 default :
 print("Error")
 }
 */
