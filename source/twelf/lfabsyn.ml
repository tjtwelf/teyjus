(** Descibes the abstract syntax representation for LF. *)

type pos = Errormsg.pos

type typefam = TypeFam of (id * kind * fixity * assoc * int * (obj ref) list ref * pos)

and obj = Object of (id * typ * fixity * assoc * int * pos)

and fixity =
    Infix
  | Prefix
  | Postfix

and assoc =
    None
  | Right
  | Left

and kind =
    PiKind of (id * typ * kind * pos)
  | ImpKind of (typ * kind * pos)
  | Type of pos

and typ =
    PiType of (id * typ * typ * pos)
  | AppType of (id * term list * pos)
  | ImpType of (typ * typ * pos)
  | IdType of (id * pos)

and term =
    AbsTerm of (id * typ * term * pos)
  | AppTerm of (id * term list * pos)
  | IdTerm of (id * pos)

and id =
  | Const of (string * pos)
  | Var of (string * pos)



let rec print_typefam (TypeFam(id,k,_,_,_,_,_)) =
  (print_id id) ^ " : " ^ (print_kind k) ^ "."

and print_obj (Object(id,ty,_,_,_,_)) =
  (print_id id) ^ " : " ^ (print_typ ty) ^ "."

and print_kind k =
  match k with
      PiKind(id,ty,body,_) -> 
        "({ " ^ (print_id id) ^ " : " ^ (print_typ ty) ^ "} " ^ (print_kind body) ^ ")"
    | ImpKind(ty,body,_) -> 
        "(" ^ (print_typ ty) ^ " -> " ^ (print_kind body) ^ ")"
    | Type(_) -> "type"

and print_typ ty =
  match ty with
      PiType(id,t1,t2,_) -> 
        "({ " ^ (print_id id) ^ " : " ^ (print_typ t1) ^ "} " ^ (print_typ t2) ^ ")"
    | AppType(t,tms,_) ->
        let tmlist =
          List.fold_left (fun s tm -> s ^ " " ^ (print_term tm)) "" tms
        in
        "(" ^ (print_id t) ^ " " ^ tmlist ^ ")"
    | ImpType(t1,t2,_) ->
        "(" ^ (print_typ t1) ^ " -> " ^ (print_typ t2) ^ ")"
    | IdType(id,_) ->
        print_id id

and print_term tm =
  match tm with
      AbsTerm(id,ty,body,_) -> 
        "([" ^ (print_id id) ^ " : " ^ (print_typ ty) ^"] " ^ (print_term body) ^ ")"
    | AppTerm(head, tms,_) -> 
        let tmlist = 
          List.fold_left (fun s t -> s ^ " " ^ (print_term t)) "" tms
        in
        "(" ^ (print_id head) ^ " " ^ tmlist ^ ")"
    | IdTerm(id,_) -> print_id id

and print_id id =
  match id with
      Const(n,_)
    | Var(n,_) -> n

let get_typefam_pos (TypeFam(_,_,_,_,_,_,p)) = p
let get_obj_pos (Object(_,_,_,_,_,p)) = p
let get_kind_pos k = 
  match k with
      PiKind(_,_,_,p) -> p
    | ImpKind(_,_,p) -> p
    | Type(p) -> p
let get_typ_pos t =
  match t with
      PiType(_,_,_,p) -> p
    | AppType(_,_,p) -> p
    | ImpType(_,_,p) -> p
    | IdType(_,p) -> p
let get_term_pos t =
  match t with
      AbsTerm(_,_,_,p) -> p
    | AppTerm(_,_,p) -> p
    | IdTerm(_,p) -> p
let get_id_pos id =
  match id with
      Const(_,p) -> p
    | Var(_,p) -> p

let get_typefam_name (TypeFam(name,_,_,_,_,_,_)) = print_id name
let get_obj_name (Object(name,_,_,_,_,_)) = print_id name

let get_typefam_kind (TypeFam(_,k,_,_,_,_,_)) = k
let get_obj_typ (Object(_,t,_,_,_,_)) = t
