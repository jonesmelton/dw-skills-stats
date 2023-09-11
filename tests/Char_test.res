open Vitest

describe("raw level bonus", () => {
  it("calculates under 20 levels", t => {
    t->assertions(1)
    expect(Char.Bonus.raw_level_bonus(10))->Expect.toBe(50)
  })

  it("calculates between 20-40 levels", t => {
    t->assertions(1)
    expect(Char.Bonus.raw_level_bonus(25))->Expect.toBe(112)
  })

  it("calculates between 40-60 levels", t => {
    t->assertions(1)
    expect(Char.Bonus.raw_level_bonus(55))->Expect.toBe(165)
  })

  it("calculates 60+ levels", t => {
    t->assertions(1)
    expect(Char.Bonus.raw_level_bonus(150))->Expect.toBe(215)
  })
})

describe("bonus multiplier", () => {
  it("calculates the modifier", t => {
    t->assertions(1)
    let res = Char.Skill.bonus_multiplier(12.0, 12.0, 18.0, 18.0, 18.0)
        ->Js.Float.toFixedWithPrecision(~digits=4)
    expect(res)->Expect.toBe("1.1419")
  })
})

describe("StatSet", () => {
  it("makes a new", t => {
    t->assertions(1)
    let ss = Char.StatSet.make(13, 13, 13, 13, 13)
    expect(ss.cons)->Expect.toBe(13)
  })
})

describe("Skill", () => {
  open Char.Skill
  it("makes a new", t => {
    t->assertions(1)
    let fi_me_da = [D(4), S(1)]
    expect(fi_me_da)->Expect.toStrictEqual([D(4), S(1)])
  })

  it("generates relevant stats", t => {
    t->assertions(1)

    let statset = Char.StatSet.make(8, 10, 12, 14, 16)
    let co_ma_pas = [D(2), I(1), S(2)]
    let total = stat_product(co_ma_pas, statset)
    expect(total)->Expect.toBe(235200)
  })

  it("calculates the multiplier", t => {
    t->assertions(1)

    let statset = Char.StatSet.make(12, 10, 12, 18, 16)
    let co_ma_pas = [C(2), S(3)]
    let total = stat_product(co_ma_pas, statset)->bonus_mult
    let res = total->Js.Float.toFixedWithPrecision(~digits=4)

    expect(res)->Expect.toBe("1.1419")
  })

  it("calculates the correct bonus", t => {
    t->assertions(1)

    let statset = Char.StatSet.make(8, 19, 12, 17, 9)
    let ad_pe = [I(2), W(3)]
    let bonus = effective_bonus(ad_pe, statset, 140)

    expect(bonus)->Expect.toBe(195)
  })
})
