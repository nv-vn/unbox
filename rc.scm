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
      (weight "bold")    ; Add bold/normal
      (slant "normal"))  ; Add italic/normal
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
    (popup-time 875)))
