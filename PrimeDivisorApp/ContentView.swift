//
//  ContentView.swift
//  PrimeDivisorApp
//
//  Created by 神　樹里乃 on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var showCount: String = ""
    @State private var listNumbers: [Int] = []
    @State private var isShowingAlert: Bool = false

    var body: some View {
        VStack {
            TextField("２以上の整数を入力してください", text: $inputText)
                .padding()
            HStack {
                Button {
                    if let castedNumber = canVastToIntType(inputText: inputText) {
                        listNumbers = findPrimeNumbers(numberToCheck: castedNumber)
                        showCount = "\(inputText) の素数は、\(listNumbers.count)個です"
                    } else {
                        cannotCastInt()
                    }
                    inputText = ""
                } label: {
                    Text("素数チェック")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    if let castedNumber = canVastToIntType(inputText: inputText) {
                        listNumbers = findDivisors(numberToCheck: castedNumber)
                        showCount = "\(inputText) の素数は、\(listNumbers.count + 1)個です"
                    } else {
                        cannotCastInt()
                    }
                    inputText = ""
                } label: {
                    Text("約数チェック")
                }
                .buttonStyle(.borderedProminent)
            }
            isShowingAlert ? Text("") : Text("\(showCount)")
            List(listNumbers, id: \.self) { number in
                Text("\(number)")
            }
        }
        .alert("２以上の整数を入力してください", isPresented: $isShowingAlert) {

            Button("OK") { }
        }
    }

    func canVastToIntType(inputText: String) -> Int? {
        if let intNumber = Int(inputText) {
            if intNumber > 1 {
                return intNumber
            }
        }
        return nil
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

    func cannotCastInt() {
        showCount = ""
        listNumbers = []
        isShowingAlert.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
