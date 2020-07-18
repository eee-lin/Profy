//
//  Profile.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/12.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Profile: Object {
    static let realm = try! Realm()
    
    @objc dynamic private var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var nickname: String = ""
    @objc dynamic var relation: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var address: String = "" //住所
    @objc dynamic var phonenumber: String = ""
    @objc dynamic var mail: String = ""
    @objc dynamic var sns: String = ""
    @objc dynamic var memo: String = "" //メモ
    @objc dynamic var whentoknow: String = "" //いつ知り合った？
    @objc dynamic var wheretoknow: String = "" //どこで知り合った？

    @objc dynamic var bloodtype: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var horoscope: String = ""
    @objc dynamic var myboom: String = ""
    @objc dynamic var merit: String = ""
    @objc dynamic var weakpoint: String = ""
    @objc dynamic var skill: String = ""
    @objc dynamic var hobby: String = ""
    @objc dynamic var personality: String = ""
    @objc dynamic var food: String = ""
    @objc dynamic var drink: String = ""
    @objc dynamic var sweet: String = ""
    @objc dynamic var talent: String = ""
    @objc dynamic var animal: String = ""
    @objc dynamic var place: String = ""
    @objc dynamic var book: String = ""
    @objc dynamic var app: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var music: String = ""
    @objc dynamic var movie: String = ""
    @objc dynamic var drama: String = ""
    @objc dynamic var word: String = ""
    @objc dynamic var dream: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var school: String = ""
    @objc dynamic var work: String = ""
    
    @objc dynamic var _image: UIImage? = nil
    @objc dynamic var image: UIImage? {
        
        set{
            self._image = newValue
            if let value = newValue {
                self.imageData = value.pngData() as NSData?
            }
        }
        get{
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                self._image = UIImage(data: data as Data)
                return self._image
            }
            return nil
        }
    }
    
    @objc dynamic private var imageData: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    static func create() -> Profile {
        let customMemo = Profile()
        customMemo.id = lastId()
        return customMemo
    }
    
    static func loadAll() -> [Profile] {
        let memos = realm.objects(Profile.self).sorted(byKeyPath: "id", ascending: false)
        var memoArray: [Profile] = []
        for memo in memos {
            memoArray.append(memo)
        }
        return memoArray
    }
    
    static func deleteAll() {
        let memos = realm.objects(Profile.self)
        try! realm.write {
            realm.delete(memos)
        }
    }
    
    static func lastId() -> Int {
        if let memo = realm.objects(Profile.self).last {
            return memo.id + 1
        } else {
            return 1
        }
    }
    
    func save() {
        try! Profile.realm.write {
            Profile.realm.add(self)
        }
    }
    
    // データを更新(Update)するためのコード
      static func update(beforeUser: String, afterUser: String) {
        let objects = realm.objects(Profile.self).filter("name == '\(beforeUser)'")
        try! realm.write {
          objects.setValue(afterUser, forKey: "user")
        }
      }

}
