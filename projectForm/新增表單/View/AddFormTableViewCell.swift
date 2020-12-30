//
//  AddFormTableViewCell.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import UIKit
struct associatedKey {
    static var key = "kcollvBtn"
}
extension UIButton{
    var sectionName:String!{
        get{
            return (objc_getAssociatedObject(self, &associatedKey.key) as! String)
        }set(newValue){
            objc_setAssociatedObject(self, &associatedKey.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
class AddFormTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    

    var addBtn:UIButton!
    var collV:AddFormProductCollectionView!
    var textField:MyTextField!
    var pickViewData = MyPickViewModel()
    var sectionName:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpHasTextField(currentSectionName:String,inputPickView:Bool,row:Int){
        if textField == nil{
            textField = MyTextField()
            textField.row = row
            textField.setUp(inputPickView: inputPickView,pickDelegate: inputPickView ? self:nil,pickDataSource: inputPickView ? self:nil, setChangeDelegate: nil, setSectionName: currentSectionName)
            self.addSubview(textField)
        }
        let leading = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
        let top = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10)
        let bottom = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10)
        let trailing = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
        NSLayoutConstraint.activate([leading,top,bottom,trailing])
    }
    func setup(sectionName:String){
        if collV == nil {
            let collectionViewLayOut = UICollectionViewFlowLayout()
            collectionViewLayOut.minimumInteritemSpacing = 5
            collectionViewLayOut.minimumLineSpacing = 5
            collectionViewLayOut.scrollDirection = .horizontal
            collectionViewLayOut.itemSize = CGSize(width: (self.frame.size.width * 0.3) - 10, height: (self.frame.size.width * 0.3) - 10)
            collV = AddFormProductCollectionView(frame: .zero, collectionViewLayout: collectionViewLayOut)
            collV.delegate = self
            collV.dataSource = self
            collV.sectionName = sectionName
            self.sectionName = sectionName
        }
        collV.setAutoLayOut(mainView: self, width: Int(self.frame.size.width * 0.2))
        if addBtn == nil{
            addBtn = UIButton()
            addBtn.setImage(UIImage(named: "add-button"), for: .normal)
            addBtn.addTarget(self, action: #selector(touchAddBtn(sender:)), for: .touchUpInside)
            self.addSubview(addBtn)
            addBtn.translatesAutoresizingMaskIntoConstraints = false
        }
        let leading = NSLayoutConstraint(item: addBtn, attribute: .leading, relatedBy: .equal, toItem: collV, attribute: .trailing, multiplier: 1.0, constant: 10)
        let top = NSLayoutConstraint(item: addBtn, attribute: .top, relatedBy: .equal, toItem: collV, attribute: .top, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: addBtn, attribute: .bottom, relatedBy: .equal, toItem: collV, attribute: .bottom, multiplier: 1.0, constant: 0)
        let width = NSLayoutConstraint(item: addBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: self.frame.size.width * 0.2)
        self.addConstraints([leading,top,bottom,width])
    }
    @objc func touchAddBtn(sender:UIButton){
//        print("touchAddBtn sectionName:\(sender.sectionName)")
        collV.setNum(width: self.frame.size.width * 0.1, name: sectionName)
        UIView.animate(withDuration: 0.5) {
            self.setNeedsUpdateConstraints()
            self.layoutIfNeeded()
        }
    }

    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("numberOfItemsInSection num:\(collV.getNum())")
        return collV.getNum()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFormProductCollectionViewCell", for: indexPath) as! AddFormProductCollectionViewCell
        let str = collV.arr[indexPath.row]
        cell.setAutoLayOut(name: sectionName,currentStr: str, whichNum: indexPath.row, changeDelegate: collV)
        return cell
    }
    //MARK:UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewData.arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewData.arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numStr = pickViewData.arr[row]
        let row = textField.row
        let dic:NSDictionary = ["row":row,"numStr":numStr]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "pickViewNotification"), object: dic)
    }
}
