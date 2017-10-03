//
//  SearchVC+URLSessionDelegates.swift
//  HalfTunes
//
//  Created by don't touch me on 10/2/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

//  URLSessionDownloadDelegate extension
extension SearchViewController: URLSessionDownloadDelegate {
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL) {
    
    //1 Extract the original request URL from the task, look up the corresponding Download in your active downloads, and remove it from that dictionary.
    guard let sourceURL = downloadTask.originalRequest?.url else { return }
    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil
    
    //2 Pass the URL to the localFilePath(for:) helper method in SearchViewController.swift, which generates a permanent local file path to save to, by appending the lastPathComponent of the URL to the path of the app’s Documents directory.
    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)
    
    //3 Move the downloaded file from its temporary file location to the desired destination file path, first clearing out any item at that location before you start the copy task. You also set the download track’s downloaded property to true.
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      download?.track.downloaded = true
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
    //4 se the download track’s index property to reload the corresponding cell.
    if let index = download?.track.index {
      DispatchQueue.main.async {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
  }
}
