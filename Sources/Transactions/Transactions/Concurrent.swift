//
// Concurrent.swift
//

import Foundation

extension Transaction {
    public func merge<T: Transaction>(
        with transaction: T
    ) -> Transactions.Concurrent2<Self, T> where T.Input == Input{
        .init(self, transaction)
    }
}

extension Transactions {
    public struct Concurrent2<T0: Transaction, T1: Transaction>: Transaction where T0.Input == T1.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output)

        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)

            return try await (o0, o1)
        }
    }

    public struct Concurrent3<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output)

        let t0: T0
        let t1: T1
        let t2: T2

        public init(_ t0: T0, _ t1: T1, _ t2: T2) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)

            return try await (o0, o1, o2)
        }
    }

    public struct Concurrent4<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)

            return try await (o0, o1, o2, o3)
        }
    }

    public struct Concurrent5<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input {
        public typealias Input = T0.Input

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
        }

        public func run(on input: Input) async throws -> (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output) {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)

            return try await (o0, o1, o2, o3, o4)
        }
    }

    public struct Concurrent6<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction,
        T5: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input, T5.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output, T5.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4
        let t5: T5

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
            self.t5 = t5
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)
            async let o5 = try await t5.run(on: input)

            return try await (o0, o1, o2, o3, o4, o5)
        }
    }

    public struct Concurrent7<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction,
        T5: Transaction,
        T6: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input, T5.Input == T0.Input, T6.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output, T5.Output, T6.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4
        let t5: T5
        let t6: T6

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
            self.t5 = t5
            self.t6 = t6
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)
            async let o5 = try await t5.run(on: input)
            async let o6 = try await t6.run(on: input)

            return try await (o0, o1, o2, o3, o4, o5, o6)
        }
    }

    public struct Concurrent8<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction,
        T5: Transaction,
        T6: Transaction,
        T7: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input, T5.Input == T0.Input, T6.Input == T0.Input, T7.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output, T5.Output, T6.Output, T7.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4
        let t5: T5
        let t6: T6
        let t7: T7

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
            self.t5 = t5
            self.t6 = t6
            self.t7 = t7
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)
            async let o5 = try await t5.run(on: input)
            async let o6 = try await t6.run(on: input)
            async let o7 = try await t7.run(on: input)

            return try await (o0, o1, o2, o3, o4, o5, o6, o7)
        }
    }

    public struct Concurrent9<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction,
        T5: Transaction,
        T6: Transaction,
        T7: Transaction,
        T8: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input, T5.Input == T0.Input, T6.Input == T0.Input, T7.Input == T0.Input, T8.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output, T5.Output, T6.Output, T7.Output, T8.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4
        let t5: T5
        let t6: T6
        let t7: T7
        let t8: T8

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
            self.t5 = t5
            self.t6 = t6
            self.t7 = t7
            self.t8 = t8
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)
            async let o5 = try await t5.run(on: input)
            async let o6 = try await t6.run(on: input)
            async let o7 = try await t7.run(on: input)
            async let o8 = try await t8.run(on: input)

            return try await (o0, o1, o2, o3, o4, o5, o6, o7, o8)
        }
    }

    public struct Concurrent10<
        T0: Transaction,
        T1: Transaction,
        T2: Transaction,
        T3: Transaction,
        T4: Transaction,
        T5: Transaction,
        T6: Transaction,
        T7: Transaction,
        T8: Transaction,
        T9: Transaction
    >: Transaction where T0.Input == T1.Input, T2.Input == T0.Input, T3.Input == T0.Input, T4.Input == T0.Input, T5.Input == T0.Input, T6.Input == T0.Input, T7.Input == T0.Input, T8.Input == T0.Input, T9.Input == T0.Input {
        public typealias Input = T0.Input
        public typealias Output = (T0.Output, T1.Output, T2.Output, T3.Output, T4.Output, T5.Output, T6.Output, T7.Output, T8.Output, T9.Output)

        let t0: T0
        let t1: T1
        let t2: T2
        let t3: T3
        let t4: T4
        let t5: T5
        let t6: T6
        let t7: T7
        let t8: T8
        let t9: T9

        public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8, _ t9: T9) {
            self.t0 = t0
            self.t1 = t1
            self.t2 = t2
            self.t3 = t3
            self.t4 = t4
            self.t5 = t5
            self.t6 = t6
            self.t7 = t7
            self.t8 = t8
            self.t9 = t9
        }

        public func run(on input: Input) async throws -> Output {
            async let o0 = try await t0.run(on: input)
            async let o1 = try await t1.run(on: input)
            async let o2 = try await t2.run(on: input)
            async let o3 = try await t3.run(on: input)
            async let o4 = try await t4.run(on: input)
            async let o5 = try await t5.run(on: input)
            async let o6 = try await t6.run(on: input)
            async let o7 = try await t7.run(on: input)
            async let o8 = try await t8.run(on: input)
            async let o9 = try await t9.run(on: input)

            return try await (o0, o1, o2, o3, o4, o5, o6, o7, o8, o9)
        }
    }
}
