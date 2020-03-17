//
//  AlbumsViewController.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//
import UIKit

class AlbumsViewController: UIViewController {
  var albumViewModels = [AlbumViewModel]()
  let pendingOperations = PendingOperations()
  let animator = Animator()
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    self.navigationItem.title = "Albums".localized
    navigationController?.delegate = self
    setTableView()
    getAlbums()
  }
  
  func setTableView() {
    view.addSubview(tableView)
    tableView.register(AlbumCell.self, forCellReuseIdentifier: String(describing: AlbumCell.self))
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.setAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor )
  }
  
  func getAlbums() -> Void {
    BusinessManager.shared.getAlbums(successHandler: { [weak self] albums in
      self?.albumViewModels = albums.map {
        return AlbumViewModel(album: $0)
      }
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
      }, errorHandler: { error in
        if let error = error {
          print("Error: \(error)".localized)
        }
    })
  }
}

// MARK: - UITableViewDataSource methods

extension AlbumsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albumViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AlbumCell.self), for: indexPath) as? AlbumCell else {
      return UITableViewCell()
    }
    
    let albumViewModel = albumViewModels[indexPath.row]
    cell.configure(albumViewModel: albumViewModel)
    
    let imageRecord = albumViewModel.imageRecord
    
    let indicator = cell.accessoryView as? UIActivityIndicatorView
    
    switch (imageRecord.state) {
    case .failed:
      indicator?.stopAnimating()
      cell.textLabel?.text = "Failed to load".localized
    case .new:
      indicator?.startAnimating()
      if !tableView.isDragging && !tableView.isDecelerating { // This is to start downloading only if the table view is not scrolling
        startOperation(for: imageRecord, at: indexPath)
      }
    default:
      break
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate methods

extension AlbumsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let albumDetailsViewController = AlbumDetailsViewController()
    tableView.deselectRow(at: indexPath, animated: false)
    albumDetailsViewController.album = albumViewModels[indexPath.row].album
    
    let albumViewModel = albumViewModels[indexPath.row]
    albumDetailsViewController.configure(albumViewModel: albumViewModel)
    
    if let cell = tableView.cellForRow(at: indexPath) as? AlbumCell {
      albumDetailsViewController.image = cell.albumImageView.image
    }
    navigationController?.pushViewController( albumDetailsViewController, animated: true)
  }
}

// MARK: - UIScrollViewDelegate methods

extension AlbumsViewController {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    suspendAllOperations()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      loadImagesForOnscreenCells()
      resumeAllOperations()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    loadImagesForOnscreenCells()
    resumeAllOperations()
  }
}

// MARK: - operation management

extension AlbumsViewController {
  func suspendAllOperations() {
    pendingOperations.downloadQueue.isSuspended = true
  }
  
  func resumeAllOperations() {
    pendingOperations.downloadQueue.isSuspended = false
  }
  
  func loadImagesForOnscreenCells() {
    guard let pathsArray = tableView.indexPathsForVisibleRows else { return }
    let allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
    
    var toBeCancelled = allPendingOperations
    let visiblePaths = Set(pathsArray)
    toBeCancelled.subtract(visiblePaths)
    
    var toBeStarted = visiblePaths
    toBeStarted.subtract(allPendingOperations)
    
    for indexPath in toBeCancelled {
      if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
        pendingDownload.cancel()
      }
      
      pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
    }
    
    for indexPath in toBeStarted {
      let albumViewModel = albumViewModels[indexPath.row]
      startOperation(for: albumViewModel.imageRecord, at: indexPath)
    }
  }
  
  func startOperation(for imageRecord: ImageRecord, at indexPath: IndexPath) {
    guard imageRecord.state == .new, pendingOperations.downloadsInProgress[indexPath] == nil else {
      return
    }
    let downloader = ImageDownloader(imageRecord)
    downloader.completionBlock = {
      if downloader.isCancelled {
        return
      }
      
      DispatchQueue.main.async{ [weak self] in
        
        self?.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
        self?.tableView.reloadRows(at: [indexPath], with: .fade)
      }
    }
    pendingOperations.downloadsInProgress[indexPath] = downloader
    
    pendingOperations.downloadQueue.addOperation(downloader) // This is the start of operation
  }
}

// MARK: - UINavigationControllerDelegate methods

extension AlbumsViewController: UINavigationControllerDelegate{
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    animator.popStyle = (operation == .pop)
    return animator
  }
}
