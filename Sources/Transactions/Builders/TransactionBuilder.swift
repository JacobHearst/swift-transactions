//
// TransactionBuilder.swift
//

import Foundation

public struct Execute<Input, Transactions: Transaction>: Transaction where Transactions.Input == Input {
    public let transactions: Transactions

    public init(
        input inputType: Input.Type = Input.self,
        @TransactionBuilder<Input> body: () -> Transactions
    ) {
        self.transactions = body()
    }

    public func run(on input: Transactions.Input) async throws -> Transactions.Output {
        try await transactions.run(on: input)
    }
}

@resultBuilder
public enum TransactionBuilder<Input> {
    @inlinable
    public static func buildPartialBlock<T: Transaction>(first: T) -> T where T.Input == Input {
        first
    }

    @inlinable
    public static func buildPartialBlock<T0, T1>(accumulated: T0, next: T1) -> Transactions.Serial2<T0, T1>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }

    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial3<T0, T1, O0, O1>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial4<T0, T1, O0, O1, O2>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }

    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial5<T0, T1, O0, O1, O2, O3>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3, O4>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial6<T0, T1, O0, O1, O2, O3, O4>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3, O4, O5>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial7<T0, T1, O0, O1, O2, O3, O4, O5>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3, O4, O5, O6>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial8<T0, T1, O0, O1, O2, O3, O4, O5, O6>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3, O4, O5, O6, O7>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial9<T0, T1, O0, O1, O2, O3, O4, O5, O6, O7>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
    
    @inlinable
    public static func buildPartialBlock<T0, T1, O0, O1, O2, O3, O4, O5, O6, O7, O8>(
        accumulated: T0, next: T1
    ) -> Transactions.Serial10<T0, T1, O0, O1, O2, O3, O4, O5, O6, O7, O8>
    where T0.Input == Input, T1.Input == Input {
        .init(accumulated, next)
    }
}
