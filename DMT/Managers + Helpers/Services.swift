//
//  Services.swift
//  DMT
//
//  Created by Synergy on 15/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import Foundation

//
//  Services.swift
//  DMT
//
//  Created by Synergy on 15/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//


import Foundation

class Services {
    
    static func loginService(params: Parameters, completionHandler: @escaping (FetchResult<UserRegister>) -> Void) {
        
        ServerRequestManager.instance.postRequest(params: params as Parameters,
                                                  url: ServerRequestConstants.URLS.LOGIN_URL,
                                                  postCompleted: completionHandler)
        
        
    }
    
    
}