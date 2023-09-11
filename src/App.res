@module("./logo.svg") external logo: string = "default"
%%raw(`import './App.css'`)

let initial = Char.StatSet.make(13, 13, 13, 13, 13)


@react.component
let make = () => {
  let (stats, setstats) = React.useState(() => initial)
  let stat_total = () => { stats.cons + stats.dext + stats.inte + stats.strn + stats.wisd }
  let stat_diff = () => {65 - stat_total()}
  let stat_change_handler = evt => {
    ReactEvent.Form.preventDefault(evt)
    let name = ReactEvent.Form.target(evt)["name"]
    let newval = ReactEvent.Form.target(evt)["value"]
    let update = switch newval->Int.fromString {
        | None => 0
        | Some(i) => i
    }
    switch name {
        | "con" => setstats(cur => {...cur, cons: update})
        | "dex" => setstats(cur => {...cur, dext: update})
        | "int" => setstats(cur => {...cur, inte: update})
        | "str" => setstats(cur => {...cur, strn: update})
        | "wis" => setstats(cur => {...cur, wisd: update})
        | _ => Console.error("bad input")
    }
  }
      <div className="App">
      
      <div className="flex items-start bg-white rounded-xl shadow-lg text-xl font-medium">
      <label htmlFor="con" className="rounded-xl shadow-lg h-16 w-32 shrink-0">
      {"con: "->React.string}
      <input type_="number" id="con" name="con" min="0" value={stats.cons->Int.toString} onChange={stat_change_handler} className="w-16"/> 
      </label>

    <label htmlFor="dex" className="rounded-xl shadow-lg h-16 w-32 shrink-0">
    {"dex: "->React.string}
    <input type_="number" id="dex" name="dex" min="0" value={stats.dext->Int.toString} onChange={stat_change_handler}  className="w-16" />
    </label>

    <label htmlFor="int" className="rounded-xl shadow-lg h-16 w-32 shrink-0">
    {"int: "->React.string}
    <input type_="number" id="int" name="int" min="0" value={stats.inte->Int.toString} onChange={stat_change_handler}  className="w-16" /> 
    </label>

    <label htmlFor="str" className="rounded-xl shadow-lg h-16 w-32 shrink-0">
    {"str: "->React.string}
    <input type_="number" id="str" name="str" min="0" value={stats.strn->Int.toString} onChange={stat_change_handler}  className="w-16" /> 
    </label>

    <label htmlFor="wis" className="rounded-xl shadow-lg h-16 w-32 shrink-0">
    {"wis: "->React.string}
    <input type_="number" id="wis" name="wis" min="0" value={stats.wisd->Int.toString} onChange={stat_change_handler}  className="w-16" /> 
    </label>

    <p className="rounded-xl shadow-lg h-16 w-32 shrink-0">{"total: "->React.string}{stat_total()->React.int}</p>
    <p className="rounded-xl shadow-lg h-16 w-32 shrink-0">{"remaining: "->React.string}{stat_diff()->React.int}</p>
    </div>

    <div className="skill-bonuses">

  </div>
    </div>
}
