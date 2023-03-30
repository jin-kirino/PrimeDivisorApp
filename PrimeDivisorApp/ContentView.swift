//
//  ContentView.swift
//  PrimeDivisorApp
//
//  Created by 神　樹里乃 on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var listNumbers: [Int] = []
    @State private var showCount: String = ""
    @State private var isShowingAlert: Bool = false

    var body: some View {
        VStack {
            TextField("１以上の整数を入力してください", text: $inputText)
                .padding()
            HStack {
                Button {
                    if let castedNumber = canVastToIntType(inputText: inputText) {
                        listNumbers = findPrimeNumbers(numberToCheck: castedNumber)
                    } else {
                        isShowingAlert.toggle()
                    }
                    inputText = ""
                    showCount = "素数"
                    print("素数ボタンがタップされた")
                } label: {
                    Text("素数チェック")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    if let castedNumber = canVastToIntType(inputText: inputText) {
                        listNumbers = findDivisors(numberToCheck: castedNumber)
                    } else {
                        isShowingAlert.toggle()
                    }
                    inputText = ""
                    showCount = "約数"
                    print("約数ボタンがタップされた")
                } label: {
                    Text("約数チェック")
                }
                .buttonStyle(.borderedProminent)
            }
            Text("\(inputText) の \(showCount) は、\(listNumbers.count + 1) 個です")
            List(listNumbers, id: \.self) { number in
                Text("\(number)")
            }
        }// VStack
        .alert("１以上の整数を入力してください", isPresented: $isShowingAlert) {
            Button("OK") { }
        }
    }

    func canVastToIntType(inputText: String) -> Int? {
        if let intNumber = Int(inputText) {
            if intNumber >= 1 {
                return intNumber
            }
        }
        return nil
    }

    func findDivisors(numberToCheck: Int) -> [Int] {
        var divisors: [Int] = []
        for number in 1 ... numberToCheck {
            // 割り切れたら追加
            if numberToCheck % number == 0 {
                divisors.append(number)
            }
        }
        return divisors
    }

    func findPrimeNumbers(numberToCheck: Int) -> [Int] {
        var primeNumbers: [Int] = []
        // 1~入力値
        for number in 1 ... numberToCheck {
            var count: Int = 0
            // 1~自分自身で割る
            for divisor in 1 ... number {
                // 割り切れたら＋１
                if number % divisor == 0 {
                    count += 1
                }
            }
            // 割り切れる回数が１と自分自身の２回
            if count == 2 {
                primeNumbers.append(number)
            }
        }
        return primeNumbers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
