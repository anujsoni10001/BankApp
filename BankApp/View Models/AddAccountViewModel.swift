//
//  AddAccountViewModel.swift
//  BankApp
//
//  Created by Anuj Soni on 10/06/22.
//

import Foundation

class AddAccountViewModel :ObservableObject{
var name : String = ""
var accountType : AccountType = .checking
var balance : String = ""
@Published var errorMessage : String = ""
}

extension AddAccountViewModel{

private var isNameValid:Bool {
!name.isEmpty
}

private var isBalanceValid:Bool{
guard let userbalance = Double(balance) else{
return false
}
return userbalance <= 0 ? false :true
}
    
private func isValid() -> Bool{

var errors = [String]()

if !isNameValid{
errors.append("Name is not Valid")
}

if !isBalanceValid{
errors.append("Balance is not Valid")
}

if !errors.isEmpty{
DispatchQueue.main.async {
self.errorMessage = errors.joined(separator:"\n")
}
return false
}
return true
}
}

extension AddAccountViewModel{
    
func createAccount(completion: @escaping (Bool) -> Void){
    
guard isValid() else {return completion(false)}
    
let createaccountrequest = CreateAccountRequest(name:name, accountType:accountType.rawValue, balance: Double(balance)!)
    
AccountService.shared.createAccount(createAccountRequest: createaccountrequest) {result in
    switch result{
    case .success(let createacccountresponse):
        if createacccountresponse.success{
        return completion(true)
        } else{
        if let error = createacccountresponse.error{
        DispatchQueue.main.async {
        self.errorMessage = error
        }
        return completion(false)
        }
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
}
}
}




