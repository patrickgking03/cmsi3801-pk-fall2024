exception Negative_Amount

let change (amount: int) =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

let first_then_apply (array: 'a list) (predicate: 'a -> bool) (consumer: 'a -> 'b option) =
  match List.find_opt predicate array with
  | Some x -> consumer x
  | None -> None

(*
  This also works:
  List.find_opt predicate array |> Option.map consumer |> Option.join
*)

let powers_generator base =
  let rec gen_from power () =
    Seq.Cons (power, gen_from (power * base))
  in
  gen_from 1

let meaningful_line_count filename =

  let is_meaningful_line line =
    let trimmed = String.trim line in
    trimmed <> "" && not (String.starts_with ~prefix:"#" trimmed)
  in

  let ic = open_in filename in
  let finally () = close_in ic in

  let rec count_lines count =
    match input_line ic with
    | line ->
      let new_count = if is_meaningful_line line then count + 1 else count in
      count_lines new_count
    | exception End_of_file ->
      count
  in
  Fun.protect ~finally (fun () -> count_lines 0)

type shape =
  | Sphere of float
  | Box of float * float * float

let volume s =
  match s with
  | Sphere r -> (4.0 /. 3.0) *. Float.pi *. (r ** 3.0)
  | Box (w, l, d) -> w *. l *. d

let surface_area s =
  match s with
  | Sphere r -> 4.0 *. Float.pi *. (r ** 2.0)
  | Box (w, l, d) -> 2.0 *. ((w *. l) +. (w *. d) +. (l *. d))

type 'a binary_search_tree =
  | Empty
  | Node of 'a * 'a binary_search_tree * 'a binary_search_tree

let rec size tree =
  match tree with
  | Empty -> 0
  | Node (_, left, right) -> size left + size right + 1

let rec insert data tree =
  match tree with
  | Empty -> Node (data, Empty, Empty)
  | Node (v, left, right) ->
    if data < v then
      Node (v, insert data left, right)
    else if data > v then
      Node (v, left, insert data right)
    else
      tree

let rec contains data tree =
  match tree with
  | Empty -> false
  | Node (v, left, right) ->
    if data < v then
      contains data left
    else if data > v then
      contains data right
    else
      true

let rec inorder tree =
  match tree with
  | Empty -> []
  | Node (v, left, right) -> inorder left @ [v] @ inorder right