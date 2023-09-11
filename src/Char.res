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
}

module Skill = {
  let bonus_multiplier = (s1, s2, s3, s4, s5) => {
    let geo_mean = Js.Math.log(s1 *. s2 *. s3 *. s4 *. s5)
    (1.0 /. 9.8) *. geo_mean -. 0.25
  }

  type stat =
    | C(int)
    | D(int)
    | I(int)
    | S(int)
    | W(int)

  type t = array<stat>
}


