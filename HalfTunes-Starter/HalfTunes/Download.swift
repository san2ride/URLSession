//
//  Download.swift
//  HalfTunes
//
//  Created by don't touch me on 10/2/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  // The track to download. The track’s url property also acts as a unique identifier for a Download.
  var track: Track
  init(track: Track) {
    self.track = track
  }
  
  // Download service sets these values:
    // The URLSessionDownloadTask that downloads the track.
  var task: URLSessionDownloadTask?
  
    // Whether the download is ongoing or paused.
  var isDownloading = false
  
    // Stores the Data produced when the user pauses a download task. If the host server supports it, your app can use this to resume a paused download in the future.
  var resumeData: Data?
  
  // Download delegate sets this value:
    // The fractional progress of the download: a float between 0.0 and 1.0.
  var Progress: Float = 0
  
}
