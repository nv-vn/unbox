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
  (margins 
    (margin-top 0)
    (margin-bottom 0)
    (margin-left 0)
    (margin-right 0))
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
        (wrap no)))))    ; And so on...
