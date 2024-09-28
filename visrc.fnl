(require :vis)

(require :plugins/vis-commentary)              ; https://github.com/r1bilski/vis-commentary
(require :plugins/vis-surround)                ; https://github.com/lutobler/vis-surround
(local cursors (require :plugins/vis-cursors)) ; https://github.com/erf/vis-cursors
(local lspc (require :plugins/vis-lspc))       ; https://github.com/fischerling/vis-lspc

(local fennel (require :fennel))
(local config-path (.. (os.getenv :HOME) :/.config/vis))

(set vis.ftdetect.filetypes.fennel.cmd ["set tw 2" "set expandtab true"])

(set cursors.path (.. config-path :/cursors))

(set lspc.diagnostic_styles.error "underlined,fore:red")
(set lspc.diagnostic_styles.warning "underlined,fore:yellow")
(set lspc.highlight_diagnostics :range)
(set lspc.ls_map.zig {:cmd :zls :name :zls})
(set lspc.ls_map.fennel {:cmd :fennel-ls :name :fennel-ls})

(fn vmap [mode key b]
  (let [actual-mode (-> mode (: :upper))]
    (vis:map (. vis.modes actual-mode) key b)))

(fn vset [attrs]
  (each [k v (pairs attrs)]
    (vis:command (string.format "set %s %s" k v))))

(fn vsubscribe [event f]
  (let [actual-event (-> event
                         (: :upper)
                         (: :gsub "-" "_"))]
    (vis.events.subscribe (. vis.events actual-event) f)))

(fn set-title [text] (vis:command (.. "!printf '\\033]2;vis: " text "\\007'")))

;; configuration on startup
(vsubscribe :init
            (fn []
              (vset {:autoindent :on})))

;; configuration per window
(vsubscribe :win-open
            (fn [win]
              (set-title (or win.file.name "new file"))
              (vset {:theme :none :showtabs :off})
              (vmap :normal ";;" :<vis-window-next>)
              (vmap :normal :vo (fn [] (vis:command "x/[ \t\r]+$/ d")) "remove all trailing white space")
              (vmap :normal "]d" (fn [] (vis:command :lspc-next-diagnostic)) "lspc: go to next diagnostic")
              (vmap :normal "[d" (fn [] (vis:command :lspc-prev-diagnostic)) "lspc: go to prev diagnostic")
              (vmap :normal " f" (fn [] (vis:command :lspc-format)) "lspc: format buffer")
              (vmap :normal :gl (fn [] (vis:command :lspc-show-diagnostics)) "lspc: show diagnostic of current line")
              (vmap :normal :<C-o> (fn [] (vis:command :lsp-back)) "lspc: jump back to previous position in history")))

(vsubscribe :file-save-post
           (fn [file]
              (set-title file.name)))

(vis:command_register :ag
                      (fn [argv]
                        (each [_ arg (ipairs argv)] (local cmd (.. "ag " arg))
                          (vis:message (.. cmd ":"))
                          (local (_ out) (vis:pipe cmd))
                          (vis:message (tostring out))))
                      "Search for each regex in argv with the_silver_searcher")

(vis:command_register :make
                      (fn [argv]
                        (var cmd "make ")
                        (each [_ arg (ipairs argv)] (set cmd (.. cmd " " arg)))
                        (local (_ out) (vis:pipe cmd))
                        (if (not= out nil) (vis:message (tostring out))
                            (vis:info "ERROR: no output from make")))
                      :Make)
