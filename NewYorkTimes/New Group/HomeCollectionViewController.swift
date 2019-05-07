//
//  HomeCollectionViewController.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    let columnLayout = FlowLayout()
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var articles = [Article]()
    var pageIndex = 0
    
    private var selectedIndex = 0
    private var originalArticlesList:[Article] = Array()
    
    var isSearching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setLayout()
        
        self.activityView.startAnimating()
    }

   
    func setLayout() {
        //collectionView.alwaysBounceVertical = true
        //collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: self.view.frame.width,height: 350)
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    func loadArticle() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.isHidden = false
            self?.activityView.startAnimating()
        }
        
        APIManager.shared.searchArticle(keyword: "singapore", pageIndex: String(pageIndex)) { (data, error) in
            if let data = data {
                self.articles.append(contentsOf: data)
                self.originalArticlesList = self.articles
                
                self.loadCV()
                self.pageIndex += 1
            } else {
                self.loadArticle()
            }
        }
    }
    
    func loadCV() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.activityView.stopAnimating()
            self?.activityView.hidesWhenStopped = true
            self?.isSearching =  false
        }
    }
}

extension HomeCollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = collectionView.contentOffset.y
        if contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
            guard !self.isSearching else { return }
            // load more data
            self.isSearching = true
            loadArticle()
        }
    }
    
    func articles(for indexPath: IndexPath) -> Article {
        return self.articles[indexPath.row]
    }
    
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("article count \(articles.count)")
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.normalCell.rawValue, for: indexPath) as! HomeImageCollectionViewCell
        
        let article = articles(for: indexPath)
        
        if let results = article.multimedia?.filter({!$0.url.isEmpty}) {
            if let media = results.first {
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.imageCell.rawValue, for: indexPath) as! HomeImageCollectionViewCell
                
                cell.activityView.startAnimating()
                cell.activityView.isHidden = false
                
                let imageUrl = Constants.domainName + "/" + media.url
                print("imageUrl \(String(describing: imageUrl))")
                
                if let url = URL.init(string: imageUrl) {
                    cell.imageView.downloadedFrom(url: url)
                    cell.activityView.stopAnimating()
                    cell.activityView.hidesWhenStopped = true
                }
            }
        }
        cell.title.text = article.headline?.main
        cell.title.accessibilityIdentifier = "titleId"
        cell.snippet.text = article.snippet
        cell.snippet.accessibilityIdentifier = "snippetId"
        if let pubDate = article.pub_date {
            cell.date.text = Date.changeStringFormat(dateString: pubDate, format: Constants.Date.DATE_FORMAT)

            cell.date.accessibilityIdentifier = "dateId"//AccessibilityIdentifier.dateLabel.rawValue
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifier.headerCell.rawValue, for: indexPath)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 100) // fix to be your intended size
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            let frameWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
//            flowLayout.itemSize = CGSize(width: frameWidth,height: 250)
//            flowLayout.invalidateLayout()
//        }
//    }
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "detailSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
       
        let pageVC = navController.viewControllers.first as! PageViewController

        let data = self.articles.enumerated().map { (offsetArticle) -> (String,Int) in
            (offsetArticle.element.web_url,offsetArticle.offset)
        }

        pageVC.detailPageList = data.map({$0.0})
        pageVC.indexPage = data[selectedIndex]
    }
}

extension HomeCollectionViewController : UISearchBarDelegate {
    @objc func searchRecords(searchText:String) {
    
        DispatchQueue.global(qos: .background).async { [weak self] in
            //Code to perform the search
            self!.articles.removeAll()
            if !searchText.isEmpty {
                self!.articles = self!.originalArticlesList.filter { (article) -> Bool in
                    return ((article.headline?.main?.lowercased().range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)) != nil)
                }
                self!.isSearching = true
                
            } else {
                self!.articles = self!.originalArticlesList
                self!.isSearching = false
            }
            DispatchQueue.main.async { [weak self] in
                //Set the results of the search in the UI
                self!.collectionView.reloadData()
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchRecords), object: searchText)
        self.perform(#selector(searchRecords), with: searchText, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.articles = originalArticlesList
        isSearching = false
        loadCV()
    }
}

