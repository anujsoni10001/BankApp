//
//  AccountSummaryViewModel.swift
//  BankApp
//
//  Created by Anuj Soni on 03/06/22.
//

import Foundation

class AccountSummaryViewModel:ObservableObject{

@Published var accounts :[AccountViewModel] = [AccountViewModel]()
    
private var _accountsModel :[Account] = [Account]()
    
    var total:Double{
        _accountsModel.map({$0.balance}).reduce(0,+)
    }
    
    func getAllAccounts(){
        AccountService.shared.getAllAccounts{ result in
            switch result{
            case .success(let accounts):
                if let accounts = accounts{
                self._accountsModel = accounts
                self.accounts = accounts.map(AccountViewModel.init)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

class AccountViewModel {
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String {
        account.name
    }
    
    var accountId: String {
        account.id.uuidString
    }
    
    var accountType: String {
        account.accountType.title
    }
    
    var balance: Double {
        account.balance
    }
}










