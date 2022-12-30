//
//  ViewController.swift
//  Music Wusic
//
//  Created by Mansoor Khan on 28/12/22.
//
// Inspired by the iOS Academy tutorial published freely on YouTube: https://www.youtube.com/watch?v=g0gmAUzeKBM&list=PL9FJ0FicYhgV57P5wa3TIXvgnHABzxcn3
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.tintColor = .black
        configureSongs()
        table.delegate = self
        table.dataSource = self
    }

    func configureSongs() {
        songs.append(Song(name: "Going Under",
                          albumName: "Evanescence",
                         artistName: "Evanescence",
                         imageName: "cover1",
                         trackName: "eva"))
        songs.append(Song(name: "Memories",
                          albumName: "Memories",
                         artistName: "Maroon 5",
                         imageName: "cover2",
                         trackName: "maroon5"))
        songs.append(Song(name: "You all over me",
                          albumName: "Taylor Swift - All Over me",
                         artistName: "Taylor Swift",
                         imageName: "cover3",
                         trackName: "taylorswift"))
            songs.append(Song(name: "Going Under",
                          albumName: "Evanescence",
                         artistName: "Evanescence",
                         imageName: "cover1",
                         trackName: "eva"))
        songs.append(Song(name: "Memories",
                          albumName: "Memories",
                         artistName: "Maroon 5",
                         imageName: "cover2",
                         trackName: "maroon5"))
        songs.append(Song(name: "You all over me",
                          albumName: "Taylor Swift - All Over me",
                         artistName: "Taylor Swift",
                         imageName: "cover3",
                         trackName: "taylorswift"))
            songs.append(Song(name: "Going Under",
                          albumName: "Evanescence",
                         artistName: "Evanescence",
                         imageName: "cover1",
                         trackName: "eva"))
        songs.append(Song(name: "Memories",
                          albumName: "Memories",
                         artistName: "Maroon 5",
                         imageName: "cover2",
                         trackName: "maroon5"))
        songs.append(Song(name: "You all over me",
                          albumName: "Taylor Swift - All Over me",
                         artistName: "Taylor Swift",
                         imageName: "cover3",
                         trackName: "taylorswift"))
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        // configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        cell.detailTextLabel?.textColor = .black
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        //songs
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
