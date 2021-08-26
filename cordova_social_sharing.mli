(* -------------------------------------------------------------------------- *)
type options = private Ojs.t

val create_options :  ?message:string          ->
                      ?subject:string          ->
                      ?files:string list       ->
                      ?url:string              ->
                      ?chooser_title:string    ->
                      ?app_package_name:string ->
                      unit                     ->
                      options
[@@js.builder]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type result = private Ojs.t

val completed : result -> bool
[@@js.get]

val app : result -> string
[@@js.get]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val share_with_options :
  options ->
  (result -> unit) ->
  (string -> unit) ->
  unit
[@@js.global "window.plugins.socialsharing.shareWithOptions"]

val share_via_twitter  :
  ?message:string                                         ->
  (* No files array, see official repo *)
  ?files:string                                           ->
  ?url:string                                             ->
  ?succ_cb:((bool -> unit) [@js.default (fun b -> ())])   ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.shareViaTwitter"]

val share_via_facebook :
  ?message:string                                         ->
  ?files:string list                                      ->
  ?url:string                                             ->
  ?succ_cb:((bool -> unit) [@js.default (fun b -> ())])   ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.shareViaFacebook"]

val share_via_instagram :
  ?message:string                                         ->
  ?files:string list                                      ->
  ?succ_cb:((unit -> unit) [@js.default (fun () -> ())])  ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.shareViaInstagram"]

val share_via_whatsapp :
  ?message:string                                         ->
  ?url:string                                             ->
  ?succ_cb:((unit -> unit) [@js.default (fun () -> ())])  ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.shareViaWhatsApp"]

(* Only the second interface is implemented because other fail on majority *)
val share_via_sms :
  ?options:options                                        ->
  ?numbers:string list                                    ->
  ?succ_cb:((bool -> unit) [@js.default (fun b -> ())])   ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.shareViaSms"]
(* -------------------------------------------------------------------------- *)

(*TODO*)
[@@@js.stop]

val available : unit -> bool

[@@@js.start]

[@@@js.implem
 let available () =
   Js_of_ocaml.Js.Optdef.test Js_of_ocaml.Js.Unsafe.global##.plugins##.socialsharing
]

val save_to_photo_album :
  ?files:string list                                      ->
  ?succ_cb:((unit -> unit) [@js.default (fun () -> ())])  ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.saveToPhotoAlbum"]

val can_share_via :
  via:string                                              ->
  ?message:string                                         ->
  ?subject:string                                         ->
  ?files:string list                                      ->
  ?succ_cb:((unit -> unit) [@js.default (fun () -> ())])  ->
  ?err_cb:((string -> unit) [@js.default (fun e -> ())])  ->
  unit                                                    ->
  unit
[@@js.global "window.plugins.socialsharing.canShareVia"]
