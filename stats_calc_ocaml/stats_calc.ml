
(* let () = print_endline "Hello World!" *)

let main () =
  let nums = Array.to_list Sys.argv (* Get program arguments as list *)
    |> List.tl (* Tail of list, skipping the program name the first entry *)
    |> List.map int_of_string (* Convert to ints, assume only numbers *)
    |> List.sort compare (* Sort using default compare *)
  in

  let n = List.length nums in
  if n = 0 then (Printf.printf "Usage: %s <numbers>\n" Sys.argv.(0); exit 1);

  (* Calculate sum using fold and accumulator *)
  let sum = List.fold_left (fun acc x -> acc +. float_of_int x) 0.0 nums in
  let mean = sum /. float_of_int n in

  (* Median - the middle entry *)
  let median = List.nth nums (n/2) in

  (* Calculate mode function *)
  let rec find_mode current_val current_count most_val most_count = function
    (* Base case when list is finally empty *)
    | [] -> if current_count > most_count then current_val else most_val
    | x :: xs -> (* First element (head), rest elements (tail) *)
        if x = current_val then
          (* current number is a repeat, increment count and process rest of the list *)
          find_mode x (current_count + 1) most_val most_count xs
        else
          (* update most occuring number and count *)
          let (new_most_val, new_most_count) = 
            if current_count > most_count then (current_val, current_count)
            else (most_val, most_count)
          in
          (* Process rest of the list *)
          find_mode x 1 new_most_val new_most_count xs
  in

  (* Calculate mode *)
  let mode = find_mode (List.hd nums) 0 (List.hd nums) 0 nums in

  Printf.printf "Mean: %.2f\n" mean;
  Printf.printf "Median: %d\n" median;
  Printf.printf "Mode: %d\n" mode
  
  (* Non functional / imperative way - commented out
  let args = Sys.argv in
  let arg_count = Array.length args in

  if arg_count < 2 then
  begin
    Printf.printf "Usage: %s <numbers>\n" args.(0);
    exit 1
  end;

  Printf.printf "Program name: %s\n" args.(0);
  Printf.printf "Num args: %d\n" (arg_count - 1);

  let num_count = arg_count - 1 in
  
  let nums = Array.make num_count 0 in
  
  for i = 1 to arg_count - 1 do
    nums.(i - 1) <- int_of_string args.(i);
    Printf.printf "Argument %d: %s, %d\n" i args.(i) nums.(i - 1);
  done;

  (* Compare function *)
  let compare_int x y = compare x y in

  (* Use library sort for the numbers *)
  Array.sort compare_int nums;
  for i = 0 to num_count - 1 do
    Printf.printf "%d\n" nums.(i);
  done;


  let sum =  ref (0.0 +. float_of_int nums.(0)) in

  let most_freq = ref nums.(0) in
  let last = ref 1 in
  let most_freq_count = ref 1 in

  for i = 1 to num_count - 1 do
    sum := !sum +. float_of_int nums.(i);
    if nums.(i) = nums.(i - 1) then
      last := !last + 1
    else
    begin
      if !last > !most_freq_count then
      begin
        most_freq_count := !last;
        most_freq := nums.(i - 1);
      end;
      last := 1
    end;
  done;

  if !last > !most_freq_count then
  begin
    most_freq_count := !last;
    most_freq := nums.(num_count - 1);
  end;

  (*Printf.printf "%.2f %d %d %d\n" !sum !most_freq !last !most_freq_count*)

  let mid = nums.(num_count / 2) in
  Printf.printf "Mean: %.2f\n" (!sum /. float_of_int num_count);
  Printf.printf "Median: %d\n" mid;
  Printf.printf "Mode: %d\n" !most_freq
  *)
  
let () = main ()
