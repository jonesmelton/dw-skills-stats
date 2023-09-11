open Vitest

describe("raw level bonus", () => {
  it("calculates under 20 levels", t => {
    t->assertions(1)
    expect(Char.raw_level_bonus(10))->Expect.toBe(50)
  })

  it("calculates between 20-40 levels", t => {
    t->assertions(1)
    expect(Char.raw_level_bonus(25))->Expect.toBe(112)
  })

  it("calculates between 40-60 levels", t => {
    t->assertions(1)
    expect(Char.raw_level_bonus(55))->Expect.toBe(165)
  })

  it("calculates 60+ levels", t => {
    t->assertions(1)
    expect(Char.raw_level_bonus(150))->Expect.toBe(215)
  })
})

describe("bonus multiplier", () => {
  it("calculates the modifier", t => {
    t->assertions(1)
    let res = Char.bonus_multiplier(12.0, 12.0, 18.0, 18.0, 18.0)->Js.Float.toFixedWithPrecision(~digits=4)
    expect(res)->Expect.toBe("1.1419")
  })
})

describe("effective bonus", () => {
  it("calculates the whole thing", t => {
    t->assertions(1)
    let mult = Char.bonus_multiplier(12.0, 12.0, 18.0, 18.0, 18.0)
    let rlb = Char.raw_level_bonus(100)->Float.fromInt
    let res = rlb *. mult

    expect(res->Int.fromFloat)->Expect.toBe(216)
  })
})
