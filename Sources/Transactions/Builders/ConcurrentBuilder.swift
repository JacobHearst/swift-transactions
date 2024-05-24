//
// ConcurrentBuilder.swift
//

import Foundation

public struct Concurrent<Input, Transactions: Transaction>: Transaction where Transactions.Input == Input {
    public let transactions: Transactions

    public init(
        input inputType: Input.Type = Input.self,
        @ConcurrentBuilder<Input> body: () -> Transactions
    ) {
        self.transactions = body()
    }

    public func run(on input: Transactions.Input) async throws -> Transactions.Output {
        try await transactions.run(on: input)
    }
}

@resultBuilder
public enum ConcurrentBuilder<Input> {
    @inlinable
    public static func buildBlock<T: Transaction>(
        _ transaction: T
    ) -> T where T.Input == Input {
        transaction
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction>(
        _ t0: T0,
        _ t1: T1
    ) -> Transactions.Concurrent2<T0, T1> where T0.Input == Input, T1.Input == Input {
        .init(t0, t1)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2
    ) -> Transactions.Concurrent3<T0, T1, T2> where T0.Input == Input, T1.Input == Input, T2.Input == Input {
        .init(t0, t1, t2)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3
    ) -> Transactions.Concurrent4<T0, T1, T2, T3> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input {
        .init(t0, t1, t2, t3)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4
    ) -> Transactions.Concurrent5<T0, T1, T2, T3, T4> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input {
        .init(t0, t1, t2, t3, t4)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction, T5: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4,
        _ t5: T5
    ) -> Transactions.Concurrent6<T0, T1, T2, T3, T4, T5> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input, T5.Input == Input {
        .init(t0, t1, t2, t3, t4, t5)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction, T5: Transaction, T6: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4,
        _ t5: T5,
        _ t6: T6
    ) -> Transactions.Concurrent7<T0, T1, T2, T3, T4, T5, T6> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input, T5.Input == Input, T6.Input == Input {
        .init(t0, t1, t2, t3, t4, t5, t6)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction, T5: Transaction, T6: Transaction, T7: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4,
        _ t5: T5,
        _ t6: T6,
        _ t7: T7
    ) -> Transactions.Concurrent8<T0, T1, T2, T3, T4, T5, T6, T7> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input, T5.Input == Input, T6.Input == Input, T7.Input == Input {
        .init(t0, t1, t2, t3, t4, t5, t6, t7)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction, T5: Transaction, T6: Transaction, T7: Transaction, T8: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4,
        _ t5: T5,
        _ t6: T6,
        _ t7: T7,
        _ t8: T8
    ) -> Transactions.Concurrent9<T0, T1, T2, T3, T4, T5, T6, T7, T8> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input, T5.Input == Input, T6.Input == Input, T7.Input == Input, T8.Input == Input {
        .init(t0, t1, t2, t3, t4, t5, t6, t7, t8)
    }

    @inlinable
    public static func buildBlock<T0: Transaction, T1: Transaction, T2: Transaction, T3: Transaction, T4: Transaction, T5: Transaction, T6: Transaction, T7: Transaction, T8: Transaction, T9: Transaction>(
        _ t0: T0,
        _ t1: T1,
        _ t2: T2,
        _ t3: T3,
        _ t4: T4,
        _ t5: T5,
        _ t6: T6,
        _ t7: T7,
        _ t8: T8,
        _ t9: T9
    ) -> Transactions.Concurrent10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9> where T0.Input == Input, T1.Input == Input, T2.Input == Input, T3.Input == Input, T4.Input == Input, T5.Input == Input, T6.Input == Input, T7.Input == Input, T8.Input == Input, T9.Input == Input {
        .init(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9)
    }
}
