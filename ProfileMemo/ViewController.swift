//
//  ViewController.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/09.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import RealmSwift
import IBAnimatable

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        return cv
    }()
    //@IBOutlet weak var profileImageView: UIImageView!
    
    //var memoList: Results<Profile>!
    var profilesList:[Profile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imagesCollectionView)
        imagesCollectionView.backgroundColor = .white
        
        //autolayout
        imagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        //親ビューの左端から40ptの位置である
        imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -30).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("やばみちゃん")
        
        profilesList = Profile.loadAll()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        // Register cell classes
        //self.imagesCollectionView!.register(GeminiCell.self, forCellWithReuseIdentifier: "Cell")
        
        //Configure the animation
//        imagesCollectionView.gemini
//        .rollRotationAnimation()
//        .degree(45)
//        .rollEffect(.rollUp)
        
        // レイアウト設定
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 300, height: 300)
//        layout.minimumInteritemSpacing = 10
//        imagesCollectionView.collectionViewLayout = layout
        
        setRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.viewDidLoad()
        self.imagesCollectionView.reloadData()
        setRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setRefreshControl()
    }
    
        //セルの配置について決める
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let horizontalSpace : CGFloat = 20
//            let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
//            return CGSize(width: cellSize, height: cellSize)
//        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if self.profilesList.count == 0 {
                return 0
            } else {
                return self.profilesList.count
            }
        }
        
        // Cell が選択された場合
             func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // [indexPath.row] から画像名を探し、UImage を設定
        //      selectedImage = topsList[indexPath.row] as! [Tops]
                let alertController = UIAlertController(title: "削除", message: "画像を削除します。よろしいですか？", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                //削除
                let realm = try! Realm()
    //            let selectedtops = realm.objects(Tops.self).filter("%K == %s", "image", self.topsList[indexPath.row])
                try! realm.write() {
                    realm.delete(self.profilesList[indexPath.row])
                  }
              }
                let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
                }
                alertController.addAction(okAction)
                alertController.addAction(cancelButton)
                present(alertController,animated: true,completion: nil)
          }
        
        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            // “Cell” はストーリーボードで設定したセルのID
            let cell =
                imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                   for: indexPath) as! CustomCell
            //cell.backgroundColor = .red
            let profile: Profile = self.profilesList[indexPath.row]
            // Tag番号を使ってImageViewのインスタンス生成
//            let photoimageView = cell.contentView.viewWithTag(1) as! UIImageView
//            // 画像配列の番号で指定された要素の名前の画像をUIImageとする
            cell.bg.image = profile.image
            //cell.bg.layer.cornerRadius = cell.bg.bounds.width / 2.0
            
            //self.imagesCollectionView.animateCell(cell)
            return cell
        }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(imagesCollectionView.frame.width/2.5)
        return CGSize(width: imagesCollectionView.frame.width/2.5, height: imagesCollectionView.frame.width/2.5)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.imagesCollectionView.animateVisibleCells()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        //anime
//
//        if let cell = cell as? CollectionViewCell {
//            self.imagesCollectionView.animateCell(cell)
//        }
//    }
    
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTimeline(refreshControl:)), for: .valueChanged)
        imagesCollectionView.addSubview(refreshControl)
    }

    @objc func reloadTimeline(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        // 更新が早すぎるので2秒遅延させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            refreshControl.endRefreshing()
        }
    }

}

class CustomCell: UICollectionViewCell {
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

