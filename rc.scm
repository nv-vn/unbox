(rc
  (resistance
    (strength 10)
    (screen-edge-strength 20))
  (focus
    (focus-new yes)
    (follow-mouse no)
    (focus-last yes)
    (under-mouse no)
    (focus-delay 200)
    (raise-on-focus no))
  (placement
    monitor-primary    ; This should be set, but the <primaryMonitor> tag is non-standard?
    (policy smart)
    (center yes))
  (theme
    (name "THEME NAME HERE")
    (title-layout "NLIMC")
    (keep-border yes)
    (animate-iconify yes)
    (font-active-window
      (name "sans")
      (size 8)
      (weight "bold")
      (slant "normal"))
    (font-inactive-window
      (name "sans")
      (size 8)
      (weight "bold")
      (slant "normal"))
    (font-menu-header
      (name "sans")
      (size 9)
      (weight "normal")
      (slant "normal"))
    (font-menu-item
      (name "sans")
      (size 9)
      (weight "normal")
      (slant "normal"))) ; Should be (in)activeonscreendisplay
  (desktops
    (number 4)
    (first-desk 1)
    (names "First" "Second" "Third" "Fourth")
    (popup-time 875))
  (resize
    (draw-contents yes)
    (popup-show non-pixel)
    (popup-position centered)
    (popup-fixed-position
      (x 10) (y 10)))
  (make-margins 0 0 0 0) ; Top/Bottom/Left/Right
  (dock
    (position top-left)
    (floating-x 0)
    (floating-y 0)
    (no-strut no)
    (stacking above)
    (direction vertical)
    (autohide no)
    (hide-delay 300)
    (show-delay 300)
    (move-button middle))
  (keyboard
    (chain-quit-key [C "g"])
    (keybind [C [A left]]
      (go-to-desktop to-left
        (wrap no)))
    (keybind [C [A right]]
      (go-to-desktop to-right
        (wrap no)))
    (keybind [C [A up]]
      (go-to-desktop to-up
        (wrap no)))
    (keybind [C [A down]]
      (go-to-desktop to-down
        (wrap no)))
    (keybind [S [A left]]
      (send-to-desktop to-left
        (wrap no)))
    (keybind [S [A right]]
      (send-to-desktop to-right
        (wrap no)))
    (keybind [S [A up]]
      (send-to-desktop to-up
        (wrap no)))
    (keybind [S [A down]]
      (send-to-desktop to-up
        (wrap no)))
    (keybind [W "F1"]
      (go-to-desktop 1))
    (keybind [W "F2"]
      (go-to-desktop 2))
    (keybind [W "F3"]
      (go-to-desktop 3))
    (keybind [W "F4"]
      (go-to-desktop 4))
    (keybind [W "d"]
      (toggle-show-desktop))
 ;; Key bindings for windows
    (keybind [A "F4"]
      (close))
    (keybind [A "Escape"]
      (action-lower)
      (action-focus-to-bottom)
      (action-unfocus))
    (keybind [A "space"]
      (show-menu
        (menu "client-menu")))
;; Take a screenshot of the current window with scrot when Alt+Print are pressed
    (keybind [A "Print"]
      (execute "scrot -s"))
;; Keybindings for window switching
    (keybind [A "Tab"]
      (next-window
        (final-actions
          (action-focus)
          (action-raise)
          (unshade))))
    (keybind [A [S "Tab"]]
      (previous-window
        (final-actions
          (action-focus)
          (action-raise)
          (unshade))))
    (keybind [C [A "Tab"]]
      (next-window
        (panels yes)
;;      (desktop yes) ;; FIXME!
        (final-actions
          (action-focus)
          (action-raise)
          (unshade))))
;; Keybindings for window switching with the arrow keys
    (keybind [W [S right]]
      (directional-cycle-windows
        (direction right))) ;; FIXME?
    (keybind [W [S left]]
      (directional-cycle-windows
        (direction left))) ;; FIXME?
    (keybind [W [S up]]
      (directional-cycle-windows
        (direction up))) ;; FIXME?
    (keybind [W [S down]]
      (directional-cycle-windows
        (direction down))) ;; FIXME?
;; Keybindings for running applications
    (keybind [W "e"]
      (execute
        [(enabled true) (name "Konqueror")]
        "kfmclient openProfile filemanagement"))
;; Launch scrot when Print is pressed
    (keybind "Print"
      (execute "scrot")))
  (mouse
;;  (drag-threshold 1) ;; FIXME!
;;  (double-click-time 500) ;; FIXME!
;;  (screen-edge-warp-time 400) ;; FIXME!
;;  (screen-edge-warp-mouse false) ;; FIXME!
    (context "Frame")))
