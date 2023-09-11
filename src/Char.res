module Bonus = {
  let rlb_low = level => {
    let mod_bonus = 2.5 *. Float.fromInt(level - 20)
    Float.toInt(mod_bonus +. 100.0)
  }

  let rlb_mid = level => {
    level - 40 + 150
  }

  let rlb_high = level => {
    let mod_bonus = 0.5 *. Float.fromInt(level - 60)
    Float.toInt(mod_bonus +. 170.0)
  }

  let raw_level_bonus = level => {
    switch level {
        | 0 => 0
        | lvl if lvl < 21 => 5 * lvl
        | lvl if lvl < 41 => rlb_low(lvl)
        | lvl if lvl < 61 => rlb_mid(lvl)
        | lvl => rlb_high(lvl)
    }
  }
}

module StatSet = {
  type t = {
    cons: int,
    dext: int,
    inte: int,
    strn: int,
    wisd: int
  }

  let make = (c, d, i, s, w) => {
    {
      cons: c,
      dext: d,
      inte: i,
      strn: s,
      wisd: w
    }
  }
}

module Skill = {
  let bonus_multiplier = (s1, s2, s3, s4, s5) => {
    let geo_mean = Js.Math.log(s1 *. s2 *. s3 *. s4 *. s5)
    (1.0 /. 9.8) *. geo_mean -. 0.25
  }

  type component =
    | C(int)
    | D(int)
    | I(int)
    | S(int)
    | W(int)

  let get_stat = (statset: StatSet.t, stat: component): array<int> => {
    switch stat {
        | C(count) => Array.make(count, statset.cons)
        | D(count) => Array.make(count, statset.dext)
        | I(count) => Array.make(count, statset.inte)
        | S(count) => Array.make(count, statset.strn)
        | W(count) => Array.make(count, statset.wisd)
    }
  }

  type t = array<component>

  let stat_product = (t, statset) => {
    let stat = get_stat(statset)
    Array.map(t, stat)
      ->Array.concatMany
      ->Array.reduce(1, (acc, val) => { acc * val})
  }

  let bonus_mult = product => {
    // geometric mean of stat points
    // 1 / 9.8 is geo series of powers of 2
    // I do not know what -0.25 does here,
    // irreducible uses it and the numbers come out correct with it.
    (1.0 /. 9.8) *. Js.Math.log(product->Float.fromInt) -. 0.25
  }

  let effective_bonus = (skillstats: t, charstats: StatSet.t, level: int): int => {
    let rlb = Bonus.raw_level_bonus(level)
    let multiplier = stat_product(skillstats, charstats)->bonus_mult
    let res_raw = rlb->Float.fromInt *. multiplier
    res_raw->Float.toInt
  }
}


