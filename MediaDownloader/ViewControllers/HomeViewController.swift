//
//  ViewController.swift
//  MediaDownloader
//
//  Created by Ghouse Basha Shaik on 01/12/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    fileprivate var mediaCollection: [MediaModel]?
    
    @IBOutlet weak var mediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaCollection = [MediaModel(mediaType: "image", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=fd7b185a-58e7-4e1f-9870-654736d9fa2d", mediaDownloadedPath: "", downloadedStatus: ""),
                           MediaModel(mediaType: "image", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=23d93642-0b6c-40fd-9ca2-d4b5d3a930c8", mediaDownloadedPath: "", downloadedStatus: ""),
                           MediaModel(mediaType: "image", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=93ac5b8a-69c1-44cd-803d-81701176ba3e", mediaDownloadedPath: "", downloadedStatus: ""),
                           MediaModel(mediaType: "image", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=93d64af9-d43e-4d83-8786-f20d7c78fe17", mediaDownloadedPath: "", downloadedStatus: ""),
                           MediaModel(mediaType: "pdf", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=eeda377a-aecb-4a22-8180-4214f5983967", mediaDownloadedPath: "", downloadedStatus: ""),
                           MediaModel(mediaType: "video", mediaURL: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=462688db-ad8d-405d-a823-bb9824a2c912", mediaDownloadedPath: "", downloadedStatus: "")]
        let _ = DownloadManager.shared.activate()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mediaCollection?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mediaCell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath) as? MediaTableViewCell
        var mediaRecord = mediaCollection![indexPath.row]
        mediaCell?.mediaTypeLabel.text = "Media Type: " + mediaRecord.mediaType
        if mediaRecord.downloadedStatus.isEmpty {
            mediaRecord.downloadedStatus = "started"
            mediaCollection![indexPath.row] = mediaRecord
            let url = URL(string: mediaRecord.mediaURL)!
            let task = DownloadManager.shared.activate().downloadTask(with: url)
            task.resume()
        }
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                mediaCell?.progressView.progress = progress
            }
        }
        return mediaCell!
    }
}

/*
 Image 3 - https://clientarea.indegene.com/sharemax/retrieve.jsp?id=93ac5b8a-69c1-44cd-803d-81701176ba3e
 Image 4 - https://clientarea.indegene.com/sharemax/retrieve.jsp?id=93d64af9-d43e-4d83-8786-f20d7c78fe17
 PDF - https://clientarea.indegene.com/sharemax/retrieve.jsp?id=eeda377a-aecb-4a22-8180-4214f5983967
 Video - https://clientarea.indegene.com/sharemax/retrieve.jsp?id=462688db-ad8d-405d-a823-bb9824a2c912
*/
