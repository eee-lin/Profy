//
//  ProfileViewController.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/14.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import RealmSwift
import IBAnimatable

class ProfileViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    // 1行あたりのアイテム数
//    private let itemsPerRow: CGFloat = 2
//    // レイアウト設定　UIEdgeInsets については下記の参考図を参照。
//    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)

    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var Indicator: AnimatableActivityIndicatorView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    //var memoList: Results<Profile>!
    var profilesList:[Profile] = []
    var tappedProfile : Profile!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        profilesList = Profile.loadAll()
        
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 127/255, green: 149/255, blue: 209/255, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(imagesCollectionView.bounds.width / 2.5) - 30, height: (imagesCollectionView.bounds.width / 2.5) )
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.minimumInteritemSpacing = 30
        imagesCollectionView.collectionViewLayout = layout
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (imagesCollectionView.bounds.width / 2) - 10, height: (imagesCollectionView.bounds.width / 2) - 10)
//        //layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
//        layout.minimumInteritemSpacing = 5
//        imagesCollectionView.collectionViewLayout = layout
        
        //setRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        profilesList = Profile.loadAll()
        self.imagesCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.imagesCollectionView.reloadData()
    }
    
        //セルの配置について決める
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let horizontalSpace : CGFloat = 30
//            let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
//            return CGSize(width: cellSize, height: cellSize)
//        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailViewController:DetailViewController = segue.destination as! DetailViewController
          // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
          // segue.destinationViewController は遷移先のViewController
        //let selectedIndex = imagesCollectionView.indexPath
            //prepare for segueが呼ばれた時の今選択されているセルを代入する
            detailViewController.selectedProfile = tappedProfile
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if self.profilesList.count == 0 {
                return 0
            } else {
                return self.profilesList.count
            }
        }
        
        // Cell が選択された場合
             func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
                tappedProfile = profilesList[indexPath.row]
                performSegue(withIdentifier: "toDetail", sender: nil)
          }
        
        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            // “Cell” はストーリーボードで設定したセルのID
            let cell =
                imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                   for: indexPath) as! CollectionViewCell
            //cell.backgroundColor = .red
            let profile: Profile = self.profilesList[indexPath.row]
            // Tag番号を使ってImageViewのインスタンス生成
//            let photoimageView = cell.contentView.viewWithTag(1) as! UIImageView
//            // 画像配列の番号で指定された要素の名前の画像をUIImageとする
            
            cell.profileImageView.image = profile.image
            cell.nameLabel.text = profile.name
            cell.nameLabel.textColor = UIColor(red: 127/255, green: 149/255, blue: 209/255, alpha: 0.8)
            cell.nameLabel.backgroundColor = .white
            cell.nameLabel.layer.cornerRadius = 10
            cell.nameLabel.clipsToBounds = true
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.width / 10
            
            return cell
        }
    
//    // Screenサイズに応じたセルサイズを返す
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//        return CGSize(width: widthPerItem, height: widthPerItem + 42)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    // セルの行間の設定
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print(imagesCollectionView.frame.width/2.5)
//        return CGSize(width: imagesCollectionView.frame.width/2.5, height: imagesCollectionView.frame.width/2.5)
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
