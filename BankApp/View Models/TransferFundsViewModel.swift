//
//  TransferFundsViewModel.swift
//  BankApp
//
//  Created by Anuj Soni on 17/06/22.
//
import Foundation

class TranserFundsViewModel : ObservableObject{
    
var fromAccount:AccountViewModel?
var toAccount:AccountViewModel?
var amount:String = ""
    
@Published var accounts :[AccountViewModel] = [AccountViewModel]()
@Published var errorMessage : String?

var isAmountValid:Bool{
guard let userAmount = Double(amount) else{
return false
}
return userAmount <= 0 ? false :true
}
    
var filteredAccount:[AccountViewModel]{
    guard fromAccount == nil else {
    return accounts.filter{($0.accountId) != (self.fromAccount!.accountId)}
    }
    return accounts
}


    
var fromAccountType : String{
fromAccount != nil ? fromAccount!.accountType : ""
}
    
var toAccountType :String{
toAccount != nil ? toAccount!.accountType : ""
}
    
func populateAccounts(){
    AccountService.shared.getAllAccounts{ result in
        switch result{
        case .success(let accounts):
            if let accounts = accounts{
                DispatchQueue.main.async {
                    self.accounts = accounts.map(AccountViewModel.init)
                }
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
    
private func isValid() -> Bool{
return isAmountValid
}
    
func submitTransfer(completion: @escaping () -> Void){

guard let fromAccount = fromAccount,let toAccount = toAccount,let userAmount = Double(amount) else {
return
}

    let transferrequest = TransferFundRequest(accountFromId: fromAccount.accountId.lowercased(), accountToId:toAccount.accountId.lowercased(), amount: userAmount)
    
    print(transferrequest)
    
    

    AccountService.shared.transferFunds(transferFundRequest: transferrequest){result in
        switch result{
        case .success(let transferacccountresponse):
            if transferacccountresponse.success{
            return completion()
            } else{
            DispatchQueue.main.async {
            self.errorMessage = transferacccountresponse.error
            }
            }
        case .failure(let error):
            print("hello")
            print(error.localizedDescription)
        }
    }
}

}




