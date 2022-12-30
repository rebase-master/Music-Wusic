//
//  PlayerViewController.swift
//  Music Wusic
//
//  Created by Mansoor Khan on 30/12/22.
//

import AVFoundation
import UIKit


class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []

    @IBOutlet var holder: UIView!

    var player: AVAudioPlayer!
    //User interface elements
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 //for line wrap
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 //for line wrap
        return label
    }()
  
    private let albumNameLabel: UILabel = {
        let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 //for line wrap
        return label
    }()
    
    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure(){
        //set up player
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            print("Song.trackname: \(song.trackName)")
            guard let urlString = urlString else {
                print("URL string not found")
                return
            }
            print("URLString: ---\(urlString)---")
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player else {
                return
            }
            player.volume = 0.5
            player.play()
        }
        catch {
            print("Error occurred playing song")
        }
        //setup user interface elements
        
        //album cover
        albumImageView.frame = CGRect(x: 0,
                                      y: 10,
                                      width: holder.frame.size.width,
                                      height: holder.frame.size.height - 400)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 30,
                                      width: holder.frame.size.width - 20,
                                      height: 30)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 50,
                                      width: holder.frame.size.width - 20,
                                      height: 30)
      artistNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 30 + 50,
                                      width: holder.frame.size.width - 20,
                                      height: 30)
    
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        //Labels
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        // Player controls
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 40
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 30,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        backButton.frame = CGRect(x: 30,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        //Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        
        //Styling
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        //Slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height - 60, width: holder.frame.size.width - 40, height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_ :)), for: .valueChanged)
        holder.addSubview(slider)
        
    }
    
    @objc func didTapBackButton() {
        if position > 0 {
            position -= 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position += 1
        }
        for subview in holder.subviews {
            subview.removeFromSuperview()
        }
        configure()
    }
    
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            // pause
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            albumImageView.frame = CGRect(x: 20,
                                          y: 20,
                                          width: holder.frame.size.width - 40,
                                          height: holder.frame.size.height - 420)
        } else {
            // play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            albumImageView.frame = CGRect(x: 0,
                                          y: 10,
                                          width: holder.frame.size.width,
                                          height: holder.frame.size.height - 400)
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
}
