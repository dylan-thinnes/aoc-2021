use std::slice::Iter;
use std::io::*;

fn main() {
    let mut input: String = String::new();
    let read_result = stdin().lock().read_to_string(&mut input);
    if let Err(msg) = read_result {
        println!("Could not read from stdin!");
    }

    let mut sections = input.split("\n\n");

    let callouts: Vec<u32> =
            sections.next().unwrap()
            .split(",").map(|s| s.parse().unwrap()).collect();

    let mut boards: Vec<Board> = sections.map(Board::parse).collect();

    let mut winner = None;
    'outer: for callout in callouts {
        for board in &mut boards {
            board.mark(callout);
        }

        for (idx, board) in boards.iter().enumerate() {
            println!("Winning {} {}", idx, board.winning());
            if board.winning() {
                winner = Some((idx, callout));
                break 'outer;
            }
        }
    }

    match winner {
        None => println!("Finished with no winner!"),
        Some((idx, callout)) => {
            let board = &boards[idx];

            let mut total = 0;
            for row in &board.tiles {
                for tile in row {
                    if !tile.marked {
                        total += tile.value;
                    }
                }
            }

            println!("{:?}", board);
            println!("Winning: {}", board.winning());
            println!("Result: {} {} {}", total, callout, total * callout);
        }
    }
}

#[derive(Debug)]
struct Tile {
    value: u32,
    marked: bool
}

impl Tile {
    fn new (value: u32) -> Self {
        Tile { value, marked: false }
    }

    fn mark (&mut self, target: u32) {
        if self.value == target {
            self.marked = true
        }
    }
}

#[derive(Debug)]
struct Board {
    tiles: Vec<Vec<Tile>>
}

impl Board {
    fn winning (&self) -> bool {
        self.any_row() || self.any_col()
    }

    fn any_row (&self) -> bool {
        for row in &self.tiles {
            let mut total = 0;
            for col in row {
                if col.marked { total += 1 }
            }

            if total == 5 { return true; }
        }

        false
    }

    fn any_col (&self) -> bool {
        for idx in 0..self.tiles[0].len() {
            let mut total = 0;
            for row in &self.tiles {
                if row[idx].marked { total += 1 }
            }

            if total == 5 { return true; }
        }

        false
    }

    fn mark (&mut self, target: u32) {
        for row in &mut self.tiles {
            for col in row {
                col.mark(target)
            }
        }
    }

    fn parse (src: &str) -> Self {
        let tiles =
                src
                .lines()
                .map(|line|
                    line
                    .split_whitespace()
                    .map(|digits| Tile::new(digits.parse().unwrap()))
                    .collect())
                .collect();
        Board { tiles }
    }
}
