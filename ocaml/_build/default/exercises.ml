exception Negative_Amount

let change amount =
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

(* Write your first then apply function here *)
let first_then_apply arr predicate func =
  try
    Some (func (List.find predicate arr))
  with
  | Not_found -> None

(* Write your powers generator here *)
let powers_generator base =
  let rec aux current =
    Seq.Cons (current, fun () -> aux (current * base))
  in
  aux 1

(* Write your line count function here *)
let meaningful_line_count filename =
  let ic = open_in filename in
  let rec count_lines acc =
    try
      let line = input_line ic in
      if String.trim line = "" || String.get line 0 = '#' then
        count_lines acc
      else
        count_lines (acc + 1)
    with End_of_file ->
      close_in ic;
      acc
  in
  count_lines 0

(* Write your shape type and associated functions here *)
type shape =
  | Box of { width : float; length : float; depth : float }
  | Sphere of { radius : float }

let volume shape =
  match shape with
  | Box { width; length; depth } -> width *. length *. depth
  | Sphere { radius } -> (4.0 /. 3.0) *. Float.pi *. (radius ** 3.0)

let surface_area shape =
  match shape with
  | Box { width; length; depth } ->
      2.0 *. ((width *. length) +. (width *. depth) +. (length *. depth))
  | Sphere { radius } -> 4.0 *. Float.pi *. (radius ** 2.0)

(* Write your binary search tree implementation here *)
module BinarySearchTree = struct
  type 'a tree =
    | Empty
    | Node of { value : 'a; left : 'a tree; right : 'a tree }

  let rec insert tree value =
    match tree with
    | Empty -> Node { value; left = Empty; right = Empty }
    | Node { value = v; left; right } ->
        if value < v then Node { value = v; left = insert left value; right }
        else if value > v then Node { value = v; left; right = insert right value }
        else tree

  let rec contains tree value =
    match tree with
    | Empty -> false
    | Node { value = v; left; right } ->
        if value = v then true else if value < v then contains left value else contains right value

  let rec size tree =
    match tree with
    | Empty -> 0
    | Node { left; right; _ } -> 1 + size left + size right

  let rec inorder tree =
    match tree with
    | Empty -> Seq.empty
    | Node { value; left; right } ->
        let left_seq = inorder left in
        let right_seq = inorder right in
        Seq.append left_seq (Seq.cons value right_seq)

  let to_string tree =
    let rec aux tree =
      match tree with
      | Empty -> "()"
      | Node { value; left; right } -> "(" ^ aux left ^ string_of_int value ^ aux right ^ ")"
    in
    aux tree
end