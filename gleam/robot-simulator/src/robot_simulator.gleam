import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

// maybe there is some way to use the ordinals but I don't know tbh
fn right(dir) {
  case dir {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

fn left(dir) {
  case dir {
    North -> West
    East -> North
    South -> East
    West -> South
  }
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

fn add(pos1: Position, pos2: Position) {
  Position(pos1.x + pos2.x, pos1.y + pos2.y)
}

fn from_tuple(tuple: #(Int, Int)) {
  Position(tuple.0, tuple.1)
}

type Instr {
  Advance
  LeftTurn
  RightTurn
}

fn parse_instr(str: String) -> List(Instr) {
  case str {
    "A" <> rest -> [Advance, ..parse_instr(rest)]
    "L" <> rest -> [LeftTurn, ..parse_instr(rest)]
    "R" <> rest -> [RightTurn, ..parse_instr(rest)]
    "" -> []
    _ -> panic as "improper input"
  }
}

fn match_instruction(
  dir: Direction,
  instr: Instr,
) -> Result(Position, Direction) {
  case instr {
    Advance ->
      case dir {
        North -> #(0, 1)
        East -> #(1, 0)
        South -> #(0, -1)
        West -> #(-1, 0)
      }
      |> from_tuple()
      |> Ok
    RightTurn ->
      right(dir)
      |> Error
    LeftTurn ->
      left(dir)
      |> Error
  }
}

fn next_robot(robot: Robot, instr: Instr) -> Robot {
  let res = match_instruction(robot.direction, instr)
  case res {
    Ok(pos) -> Robot(robot.direction, add(pos, robot.position))
    Error(dir) -> Robot(dir, robot.position)
  }
}

fn move_robot(robot: Robot, instr: List(Instr)) -> Robot {
  use r, thing <- list.fold(instr, robot)
  next_robot(r, thing)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  let instrs = parse_instr(instructions)
  move_robot(create(direction, position), instrs)
}
