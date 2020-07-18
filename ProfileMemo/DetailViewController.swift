//
//  DetailViewController.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/17.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedProfile: Profile!
    var resizedImage: UIImage!
    
    //紐付け
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet var selectImage: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var relationTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var snsTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    
    //Favorite
    @IBOutlet var placeTextView: UITextField!
    @IBOutlet var foodTextView: UITextField!
    @IBOutlet var drinkTextView: UITextField!
    @IBOutlet var movieTextView: UITextField!
    @IBOutlet var dramaTextView: UITextField!
    @IBOutlet var musicTextView: UITextField!
    @IBOutlet var boomTextView: UITextField!
    @IBOutlet var typeTextView: UITextField!
    @IBOutlet var hobbyTextView: UITextField!
    @IBOutlet var animalTextView: UITextField!
    @IBOutlet var bookTextView: UITextField!
    @IBOutlet var appTextView: UITextField!
    @IBOutlet var wordTextView: UITextField!
    @IBOutlet var colorTextView: UITextField!
    @IBOutlet var dreamTextView: UITextField!
    
    //More
    @IBOutlet var schoolTextView: UITextField!
    @IBOutlet var workTextView: UITextField!
    @IBOutlet var birthdayTextView: UITextField!
    @IBOutlet var bloodtypeTextView: UITextField!
    @IBOutlet var holoscopeTextView: UITextField!
    @IBOutlet var personalityTextView: UITextField!
    @IBOutlet var meritTextView: UITextField!
    @IBOutlet var weakpointTextView: UITextField!
    @IBOutlet var addressTextView: UITextField!
    @IBOutlet var whenTextView: UITextField!
    @IBOutlet var whereTextView: UITextField!
    @IBOutlet var skillTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedProfile.image
        nameTextField.text = selectedProfile.name
        nicknameTextField.text = selectedProfile.nickname
        genderTextField.text = selectedProfile.gender
        relationTextField.text = selectedProfile.relation
        memoTextView.text = selectedProfile.memo
        phoneTextField.text = selectedProfile.phonenumber
        snsTextField.text = selectedProfile.sns
        mailTextField.text = selectedProfile.mail
        
        placeTextView.text = selectedProfile.place
        foodTextView.text = selectedProfile.food
        drinkTextView.text = selectedProfile.drink
        movieTextView.text = selectedProfile.movie
        dramaTextView.text = selectedProfile.drama
        musicTextView.text = selectedProfile.music
        boomTextView.text = selectedProfile.myboom
        typeTextView.text = selectedProfile.type
        hobbyTextView.text = selectedProfile.hobby
        animalTextView.text = selectedProfile.animal
        bookTextView.text = selectedProfile.book
        appTextView.text = selectedProfile.app
        wordTextView.text = selectedProfile.word
        colorTextView.text = selectedProfile.color
        dreamTextView.text = selectedProfile.dream
        
        schoolTextView.text = selectedProfile.school
        workTextView.text = selectedProfile.word
        birthdayTextView.text = selectedProfile.birthday
        bloodtypeTextView.text = selectedProfile.bloodtype
        holoscopeTextView.text = selectedProfile.horoscope
        personalityTextView.text = selectedProfile.personality
        meritTextView.text = selectedProfile.merit
        weakpointTextView.text = selectedProfile.weakpoint
        addressTextView.text = selectedProfile.address
        whenTextView.text = selectedProfile.whentoknow
        whereTextView.text = selectedProfile.wheretoknow
        skillTextView.text = selectedProfile.skill
        
        nameTextField.delegate = self
        nicknameTextField.delegate = self
        genderTextField.delegate = self
        relationTextField.delegate = self
        mailTextField.delegate = self
        phoneTextField.delegate = self
        snsTextField.delegate = self
        memoTextView.delegate = self
        
        placeTextView.delegate = self
        foodTextView.delegate = self
        drinkTextView.delegate = self
        movieTextView.delegate = self
        dramaTextView.delegate = self
        musicTextView.delegate = self
        typeTextView.delegate = self
        boomTextView.delegate = self
        hobbyTextView.delegate = self
        animalTextView.delegate = self
        bookTextView.delegate = self
        appTextView.delegate = self
        wordTextView.delegate = self
        colorTextView.delegate = self
        dreamTextView.delegate = self
        
        schoolTextView.delegate = self
        workTextView.delegate = self
        birthdayTextView.delegate = self
        bloodtypeTextView.delegate = self
        holoscopeTextView.delegate = self
        personalityTextView.delegate = self
        meritTextView.delegate = self
        weakpointTextView.delegate = self
        addressTextView.delegate = self
        whenTextView.delegate = self
        whereTextView.delegate = self
        skillTextView.delegate = self
        
        selectImage.layer.cornerRadius = selectImage.bounds.width / 30
        imageView.layer.cornerRadius = imageView.bounds.width / 20
        imageView.image = selectedProfile.image
        
        skillTextView.layer.cornerRadius = skillTextView.bounds.width / 20
        
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 127/255, green: 149/255, blue: 209/255, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        //view.addSubView(textField)

         //ツールバーの作成　サイズはsizeToFitメソッドで自動で調整される
         let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
         //サイズの自動調整 敢えて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さない
         toolBar.sizeToFit()
         // 左側のBarButtonItemはflexibleSpace これがないと右に寄らない。
         let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
    }
    
    @objc func commitButtonTapped() {
      self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      let selectedImage = info[.originalImage] as! UIImage
      resizedImage = selectedImage.scale(byFactor: 0.7)
      imageView.image = resizedImage
      picker.dismiss(animated: true, completion: nil)
      confirmContent()
    }
    func confirmContent() {
      if imageView.image != nil {
        saveButton.isEnabled = true
      } else {
        saveButton.isEnabled = false
      }
    }
     
     @IBAction func selectprofileImage() {
     let alertController = UIAlertController(title: "画像選択", message: "画像を選択して下さい。", preferredStyle: .actionSheet)
     let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
           alertController.dismiss(animated: true, completion: nil)
         }
      let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { (action) in
         //カメラ起動
         if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
          let picker = UIImagePickerController()
          picker.sourceType = .camera
          picker.delegate = self
          self.present(picker, animated: true, completion: nil)
         } else {
             print("この機種ではカメラが使用できません。")
         }
       }
       let photoLibraryAction = UIAlertAction(title: "フォトライブラリから選択", style: .default) { (action) in
         //アルバム起動
          if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          self.present(picker, animated: true, completion: nil)
         } else {
           print("この機種ではフォトライブラリが使用できません。")
         }
       }
       alertController.addAction(cameraAction)
       alertController.addAction(cancelAction)
       alertController.addAction(photoLibraryAction)
        // iPadでは必須！
        alertController.popoverPresentationController?.sourceView = self.view
       self.present(alertController, animated: true, completion: nil)
     }
    

    @IBAction func edit() {
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択して下さい。", preferredStyle: .actionSheet)
        let  editAction = UIAlertAction(title: "編集", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            let AC = UIAlertController(title: "編集", message: "完了ですか？", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
                            //削除
                let realm = try! Realm()
                //            let selectedtops = realm.objects(Tops.self).filter("%K == %s", "image", self.topsList[indexPath.row])
                try! realm.write() {
                    self.selectedProfile.image = self.resizedImage
                    
                    self.selectedProfile.name = self.nameTextField.text!
                    self.selectedProfile.nickname = self.nicknameTextField.text!
                    self.selectedProfile.relation = self.relationTextField.text!
                    self.selectedProfile.mail = self.mailTextField.text!
                    self.selectedProfile.phonenumber = self.phoneTextField.text!
                    self.selectedProfile.sns = self.snsTextField.text!
                    self.selectedProfile.memo = self.memoTextView.text!
                    
                    self.selectedProfile.place = self.placeTextView.text!
                    self.selectedProfile.food = self.foodTextView.text!
                    self.selectedProfile.drink = self.drinkTextView.text!
                    self.selectedProfile.movie = self.movieTextView.text!
                    self.selectedProfile.drama = self.dramaTextView.text!
                    self.selectedProfile.music = self.musicTextView.text!
                    self.selectedProfile.type = self.typeTextView.text!
                    self.selectedProfile.myboom = self.boomTextView.text!
                    self.selectedProfile.hobby = self.hobbyTextView.text!
                    self.selectedProfile.animal = self.animalTextView.text!
                    self.selectedProfile.book = self.bookTextView.text!
                    self.selectedProfile.app = self.appTextView.text!
                    self.selectedProfile.word = self.wordTextView.text!
                    self.selectedProfile.color = self.colorTextView.text!
                    self.selectedProfile.dream = self.dreamTextView.text!
                    
                    self.selectedProfile.school = self.schoolTextView.text!
                    self.selectedProfile.work = self.workTextView.text!
                    self.selectedProfile.birthday = self.birthdayTextView.text!
                    self.selectedProfile.horoscope = self.holoscopeTextView.text!
                    self.selectedProfile.personality = self.personalityTextView.text!
                    self.selectedProfile.merit = self.meritTextView.text!
                    self.selectedProfile.weakpoint = self.weakpointTextView.text!
                    self.selectedProfile.address = self.addressTextView.text!
                    self.selectedProfile.whentoknow = self.whenTextView.text!
                    self.selectedProfile.wheretoknow = self.whereTextView.text!
                    self.selectedProfile.skill = self.skillTextView.text!
                    }
                self.navigationController?.popViewController(animated: true)
                }
            AC.addAction(okAction)
            AC.addAction(cancelAction)
            self.present(AC, animated: true, completion: nil)
            }

        
        let deleteAction = UIAlertAction(title: "削除", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            let AC = UIAlertController(title: "削除", message: "削除しますか？", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
                            //削除
                let realm = try! Realm()
                //            let selectedtops = realm.objects(Tops.self).filter("%K == %s", "image", self.topsList[indexPath.row])
                try! realm.write() {
                    realm.delete(self.selectedProfile)
                    }
                self.navigationController?.popViewController(animated: true)
                }
            AC.addAction(okAction)
            AC.addAction(cancelAction)
            self.present(AC, animated: true, completion: nil)
            }
        
        let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelButton)
        // iPadでは必須！
        alertController.popoverPresentationController?.sourceView = self.view
        present(alertController,animated: true,completion: nil)

    }

}
