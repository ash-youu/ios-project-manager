//
//  NameSpace.swift
//  ProjectManager
//
//  Created by 유연수 on 2023/01/19.
//

import Foundation

enum HeaderViewValue {
    static let identifier = "ListHeaderView"
    static let countImage = ".circle.fill"
}

enum ListTableViewValue {
    static let identifier = "ListTableViewCell"
    
    enum PlaceHolder {
        static let title = "title"
        static let body = "body"
        static let date = "0000. 0. 0"
    }
}

enum ItemViewPlaceHolder {
    static let title = " Title"
    static let body = """
                      할일의 내용을 입력해주세요.
                      입력 가능한 글자수는 1000자로 제한됩니다.
                      """
}

enum DatePickerValue {
    static let locale = "ko-kr"
    static let timezone = "KST"
    static let dateFormat = "yyyy. M. d."
}

enum ListViewTitle {
    static let navigationBar = "Project Manager"
    
    enum Header {
        static let todo = "TODO"
        static let doing = "DOING"
        static let done = "DONE"
    }
}

enum SwipeActionTitle {
    static let delete = "Delete"
    static let deleteImage = "xmark.bin"
}

enum TodoViewTitle {
    static let navigationBar = "TODO"
    static let cancel = "Cancel"
    static let done = "Done"
    static let edit = "Edit"
}
