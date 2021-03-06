//
//  PhotoBrowserCollectionViewController.swift
//  Photomania
//
//  Created by Essan Parto on 2014-08-20.
//  Copyright (c) 2014 Essan Parto. All rights reserved.
//

import UIKit

class PhotoBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  var photos = NSMutableOrderedSet()
  
  let imageCache = NSCache()
  let refreshControl = UIRefreshControl()
  var populatingPhotos = false
  var currentPage = 1
    
    
  let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
  let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"
  
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
    
    setupView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: CollectionView
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
    
    
    let imageUrl = (photos.objectAtIndex(indexPath.row) as! PhotoInfo).url
    cell.request?.cancel()
    
    if let image = self.imageCache.objectForKey(imageUrl) as? UIImage {
        cell.imageView.image = image
    } else {
        cell.imageView.image = nil
        
        cell.request = Alamofire.manager.request(Method.GET, imageUrl).responseImage(){
            (request,_,image,error)in
            if  error == nil && image != nil {
                
                // 下载后的图片放在缓存
                self.imageCache.setObject(image!, forKey: request.URLString)
                
                cell.imageView.alpha = 0.2
                
                var transImage = {
                    cell.imageView.image = image
                }
                
                UIView.animateWithDuration(0.35){
                    cell.imageView.alpha = 1.0
                    //                cell.imageView.image = image
                    transImage()
                }
                
                //            cell.imageView.image = image
            } else {
            }
        }
    }


    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)
  }
  
  // MARK: Helper
  
  func setupView() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    let layout = UICollectionViewFlowLayout()
    let itemWidth = (view.bounds.size.width - 2) / 3
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    layout.minimumInteritemSpacing = 1.0
    layout.minimumLineSpacing = 1.0
    layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
    
    collectionView!.collectionViewLayout = layout
    
    let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
    titleLabel.text = "Photomania"
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    navigationItem.titleView = titleLabel
    
    collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
    collectionView!.registerClass(PhotoBrowserCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoBrowserFooterViewIdentifier)
    
    refreshControl.tintColor = UIColor.whiteColor()
    refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
    collectionView!.addSubview(refreshControl)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowPhoto" {
      (segue.destinationViewController as! PhotoViewerViewController).photoID = sender!.integerValue
      (segue.destinationViewController as! PhotoViewerViewController).hidesBottomBarWhenPushed = true
    }
  }

    // 滚动加载图片，刷新视图
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
        populatePhotos()
    }
}

func populatePhotos() {
    
    if  populatingPhotos {
        return
    }
    
    populatingPhotos = true
    
    Alamofire.manager.request(Five100px.Router.PopularPhotos(self.currentPage)).responseJSON(){
        (_,_,JSON,error) in
        if  error == nil {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)){
                let photoInfos = ((JSON as! NSDictionary).valueForKey("photos") as! [NSDictionary]).filter({($0["nsfw"] as! Bool) == false}).map {PhotoInfo(id: $0["id"] as! Int, url:$0["image_url"] as! String)}
                
                let lastItem = self.photos.count
                
                self.photos.addObjectsFromArray(photoInfos)
                
                let indexPaths = (lastItem..<self.photos.count).map{NSIndexPath(forItem: $0, inSection: 0)}
                
                dispatch_async(dispatch_get_main_queue()){
                    self.collectionView!.insertItemsAtIndexPaths(indexPaths)
                }
                self.currentPage++
            }
        }
        self.populatingPhotos = false
        println("JSON------\(self.currentPage,self.populatingPhotos)",JSON)
    }
}


  func handleRefresh() {
    
    refreshControl.beginRefreshing()
    self.photos.removeAllObjects()
    self.currentPage = 1
    self.collectionView!.reloadData()
    refreshControl.endRefreshing()
    
    populatePhotos()
    
  }
}

class PhotoBrowserCollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
    var request:Request?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    
    imageView.frame = bounds
    addSubview(imageView)
  }
}

class PhotoBrowserCollectionViewLoadingCell: UICollectionReusableView {
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    spinner.startAnimating()
    spinner.center = self.center
    addSubview(spinner)
  }
}
