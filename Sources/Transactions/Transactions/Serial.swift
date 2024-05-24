//
// Serial.swift
//

import Foundation

extension Transaction {
    public func concatenate<T: Transaction>(
        with transaction: T
    ) -> Transactions.Serial2<Self, T> where T.Input == Input {
        .init(self, transaction)
    }
}

extension Transactions {
    public struct Serial2<T0: Transaction, T1: Transaction>: Transaction where T0.Input == T1.Input {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (T0.Output, T1.Output) {
            let o0 = try await t0.run(on: input)
            let o1 = try await t1.run(on: input)

            return (o0, o1)
        }
    }

    public struct Serial3<T0: Transaction, T1: Transaction, O0, O1>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, T1.Output) {
            let (o0, o1) = try await t0.run(on: input)
            let o2 = try await t1.run(on: input)

            return (o0, o1, o2)
        }
    }

    public struct Serial4<T0: Transaction, T1: Transaction, O0, O1, O2>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, T1.Output) {
            let (o0, o1, o2) = try await t0.run(on: input)
            let o3 = try await t1.run(on: input)

            return (o0, o1, o2, o3)
        }
    }

    public struct Serial5<T0: Transaction, T1: Transaction, O0, O1, O2, O3>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, T1.Output) {
            let (o0, o1, o2, o3) = try await t0.run(on: input)
            let o4 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4)
        }
    }

    public struct Serial6<T0: Transaction, T1: Transaction, O0, O1, O2, O3, O4>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3, O4) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, O4, T1.Output) {
            let (o0, o1, o2, o3, o4) = try await t0.run(on: input)
            let o5 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4, o5)
        }
    }

    public struct Serial7<T0: Transaction, T1: Transaction, O0, O1, O2, O3, O4, O5>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3, O4, O5) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, O4, O5, T1.Output) {
            let (o0, o1, o2, o3, o4, o5) = try await t0.run(on: input)
            let o6 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4, o5, o6)
        }
    }

    public struct Serial8<T0: Transaction, T1: Transaction, O0, O1, O2, O3, O4, O5, O6>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3, O4, O5, O6) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, O4, O5, O6, T1.Output) {
            let (o0, o1, o2, o3, o4, o5, o6) = try await t0.run(on: input)
            let o7 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4, o5, o6, o7)
        }
    }

    public struct Serial9<T0: Transaction, T1: Transaction, O0, O1, O2, O3, O4, O5, O6, O7>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3, O4, O5, O6, O7) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, O4, O5, O6, O7, T1.Output) {
            let (o0, o1, o2, o3, o4, o5, o6, o7) = try await t0.run(on: input)
            let o8 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4, o5, o6, o7, o8)
        }
    }

    public struct Serial10<T0: Transaction, T1: Transaction, O0, O1, O2, O3, O4, O5, O6, O7, O8>: Transaction where T0.Input == T1.Input, T0.Output == (O0, O1, O2, O3, O4, O5, O6, O7, O8) {
        let t0: T0
        let t1: T1

        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        public func run(on input: T0.Input) async throws -> (O0, O1, O2, O3, O4, O5, O6, O7, O8, T1.Output) {
            let (o0, o1, o2, o3, o4, o5, o6, o7, o8) = try await t0.run(on: input)
            let o9 = try await t1.run(on: input)

            return (o0, o1, o2, o3, o4, o5, o6, o7, o8, o9)
        }
    }
}
