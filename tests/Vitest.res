@module("vitest") external test: (string, unit => unit) => unit = "test"
@module("vitest") external describe: (string, unit => unit) => unit = "describe"
@module("vitest") external expect_: (string, unit => unit) => unit = "expect"
let expect = expect_
