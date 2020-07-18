//
//  AddProfileViewController.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/09.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import NYXImagesKit
import UITextView_Placeholder
import TextFieldEffects
import PKHUD

 class AddProfileViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
   var resizedImage: UIImage!
    var isChanged: Int = 0
    var relationTitle: String = ""

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
    
    
    let prefillTextFields = false
    
   override func viewDidLoad() {
     super.viewDidLoad()
    
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
    
    //selectRelationButton.layer.cornerRadius = selectRelationButton.bounds.width / 30
    selectImage.layer.cornerRadius = selectImage.bounds.width / 30
    imageView.layer.cornerRadius = imageView.bounds.width / 20
    imageView.image = UIImage(named: "Pbear.png")
    
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
    
   override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
    

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
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
      self.present(alertController, animated: true, completion: nil)
    }
    
   @IBAction func save() {
    if nameTextField.text!.count > 0 {
       let alertController = UIAlertController(title: "保存",message: "メモを保存します。よろしいですか？", preferredStyle: UIAlertController.Style.alert)
       let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
         // データの追加
//        let documentDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let path = documentDirPath[0] + "/tops.realm"
//        let url = URL(fileURLWithPath: path)
        let realm = try! Realm()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        let profile = Profile.create()
        if self.resizedImage != nil {
            profile.image = self.resizedImage
        } else {
            profile.image = UIImage(named: "Pbear.png")
        }
        
        profile.name = self.nameTextField.text!
        profile.nickname = self.nicknameTextField.text!
        profile.relation = self.relationTextField.text!
        profile.mail = self.mailTextField.text!
        profile.phonenumber = self.phoneTextField.text!
        profile.sns = self.snsTextField.text!
        profile.memo = self.memoTextView.text!
        
        profile.place = self.placeTextView.text!
        profile.food = self.foodTextView.text!
        profile.drink = self.drinkTextView.text!
        profile.movie = self.movieTextView.text!
        profile.drama = self.dramaTextView.text!
        profile.music = self.musicTextView.text!
        profile.type = self.typeTextView.text!
        profile.myboom = self.boomTextView.text!
        profile.hobby = self.hobbyTextView.text!
        profile.animal = self.animalTextView.text!
        profile.book = self.bookTextView.text!
        profile.app = self.appTextView.text!
        profile.word = self.wordTextView.text!
        profile.color = self.colorTextView.text!
        profile.dream = self.dreamTextView.text!
        
        profile.school = self.schoolTextView.text!
        profile.work = self.workTextView.text!
        profile.birthday = self.birthdayTextView.text!
        profile.horoscope = self.holoscopeTextView.text!
        profile.personality = self.personalityTextView.text!
        profile.merit = self.meritTextView.text!
        profile.weakpoint = self.weakpointTextView.text!
        profile.address = self.addressTextView.text!
        profile.whentoknow = self.whenTextView.text!
        profile.wheretoknow = self.whereTextView.text!
        profile.skill = self.skillTextView.text!
        
        try! realm.write {
          realm.add(profile)
        }
        self.navigationController?.popViewController(animated: true)
       }
       let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel) { (action) in
       }
       alertController.addAction(okAction)
       alertController.addAction(cancelButton)
        // iPadでは必須！
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
       present(alertController,animated: true,completion: nil)
    }else{
        HUD.flash(.labeledError(title: "名前未記入", subtitle: "名前を記入してください"), delay: 1.0)
    }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
    
    
 }

