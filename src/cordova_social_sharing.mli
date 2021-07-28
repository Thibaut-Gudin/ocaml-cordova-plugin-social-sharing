(* -------------------------------------------------------------------------- *)
type options = private Ojs.t

val create_options :
  ?message:string ->
  ?subject:string ->
  ?files:string list ->
  ?url:string ->
  ?chooser_title:string ->
  unit ->
  options
  [@@js.builder]

(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type result = private Ojs.t

val completed : result -> bool [@@js.get]

val app : result -> string [@@js.get]

(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val share_with_options : options -> (result -> unit) -> (string -> unit) -> unit
  [@@js.global "window.plugins.socialsharing.shareWithOptions"]

val share_via_twitter :
  string ->
  (* No files array, see official repo *)
  ?files:string ->
  ?url:string ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.shareViaTwitter"]

val share_via_facebook :
  string ->
  ?files:string list ->
  ?url:string ->
  ?succ_cb:((unit -> unit)[@js.default fun () -> ()]) ->
  ?err_cb:((string -> unit)[@js.default fun _ -> ()]) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.shareViaFacebook"]

val share_via_instagram :
  string ->
  ?url:string ->
  ?succ_cb:((unit -> unit)[@js.default fun () -> ()]) ->
  ?err_cb:((string -> unit)[@js.default fun _ -> ()]) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.shareViaInstagram"]

val share_via_whatsapp :
  string ->
  ?img:string ->
  ?url:string ->
  ?succ_cb:((unit -> unit)[@js.default fun () -> ()]) ->
  ?err_cb:((string -> unit)[@js.default fun _ -> ()]) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.shareViaWhatsApp"]

(* Only the second interface is implemented because other fail on majority *)
val share_via_sms :
  string ->
  ?numbers:string ->
  ?succ_cb:((string -> unit)[@js.default fun _ -> ()]) ->
  ?err_cb:((string -> unit)[@js.default fun _ -> ()]) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.shareViaSms"]

(* -------------------------------------------------------------------------- *)

(*TODO*)
[@@@js.stop]

val available : unit -> bool

[@@@js.start]

[@@@js.implem
let available () =
  Js_of_ocaml.Js.Optdef.test
    Js_of_ocaml.Js.Unsafe.global##.plugins##.socialsharing]

val save_to_photo_album :
  string list ->
  ?onSuccess:(unit -> unit) ->
  ?onError:(unit -> unit) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.saveToPhotoAlbum"]

val can_share_via :
  via:string ->
  msg:string ->
  ?subject:string ->
  ?fileOrArray:string list ->
  ?url:string ->
  successCallback:(unit -> unit) ->
  errorCallback:(unit -> unit) ->
  unit ->
  unit
  [@@js.global "window.plugins.socialsharing.canShareVia"]
