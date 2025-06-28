(* statistics.ml *)
(* This OCaml script calculates mean, median, and mode using a functional paradigm.
   It uses immutable lists, pattern matching, and higher-order functions. *)

(* Function to calculate mean *)
let mean lst =
  let total = List.fold_left (+.) 0.0 (List.map float_of_int lst) in
  total /. float_of_int (List.length lst)

(* Function to calculate median *)
let median lst =
  let sorted = List.sort compare lst in
  let n = List.length sorted in
  if n mod 2 = 0 then
    let mid1 = List.nth sorted (n / 2 - 1)
    and mid2 = List.nth sorted (n / 2) in
    float_of_int (mid1 + mid2) /. 2.0
  else
    float_of_int (List.nth sorted (n / 2))

(* Function to calculate mode(s) *)
let mode lst =
  let freq = List.fold_left (fun acc x ->
    let count = try List.assoc x acc + 1 with Not_found -> 1 in
    (x, count) :: List.remove_assoc x acc
  ) [] lst in
  let max_freq = List.fold_left (fun acc (_, c) -> max acc c) 0 freq in
  List.fold_left (fun acc (x, c) -> if c = max_freq then x::acc else acc) [] freq

(* Main entry point with test data *)
let () =
  let data = [1; 3; 2; 4; 2; 5; 2] in
  Printf.printf "Mean: %.2f\n" (mean data);
  Printf.printf "Median: %.2f\n" (median data);
  Printf.printf "Mode(s): ";
  List.iter (Printf.printf "%d ") (mode data);
  Printf.printf "\n"
