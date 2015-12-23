(define (ob-gen-xml nodes indent)
  (if (list? nodes)
      (let ([ob-gen-xml-i
             (lambda (nodes)
               (ob-gen-xml nodes (string-append "  " indent)))])
        (apply string-append (map ob-gen-xml-i nodes)))
        (if (string? nodes)
            (string-append indent nodes "\n")
            "<!-- Error encountered while generating XML -->")))

(define (ob-conf nodes)
  (string-append "<!-- Generated with ob-sexpr -->\n"
                 "<?xml version=\"1.0\" encoding=\"UTF-8\">\n"
                 "<openbox_config xmlns=\"https://openbox.org/3.4/rc\" xmlns:xi=\"https://www.w3.org/2001/XInclude\">\n"
                 (ob-gen-xml nodes "") ; No indentation by default
                 "</openbox_config>\n"))

(define-syntax rc
  (syntax-rules ()
    [(_ nodes ...)
     (define (gen-rc)
       (ob-conf (list nodes ...)))]))

(define-syntax define-xml
  (syntax-rules ()
    [(_ name xml-name)
     (define (name . sub-nodes)
       `(,(string-append "<" xml-name ">")
         ,@sub-nodes
         ,(string-append "</" xml-name ">")))]
    [(_ name xml-start xml-end)
     (define (name . sub-nodes)
       `(,xml-start
         ,@sub-nodes
         ,xml-end))]))

(define-syntax define-xml-num
  (syntax-rules ()
    [(_ name xml-name)
     (define (name num)
       (list (string-append "<" xml-name ">")
             (number->string num)
             (string-append "</" xml-name ">")))]))

(define yes "yes")
(define no "no")

(define-xml resistance "resistance")
(define-xml-num strength "strength")
(define-xml-num screen-edge-strength "screen_edge_strength")

(define-xml focus "focus")
(define-xml focus-new "focusNew")
(define-xml focus-last "focusLast")
(define-xml follow-mouse "followMouse")
(define-xml-num focus-delay "focusDelay")
(define-xml under-mouse "underMouse")
(define-xml raise-on-focus "raiseOnFocus")

(define-xml placement "placement")
(define-xml policy "policy")
(define-xml center "center")

(define undermouse "UnderMouse")
(define smart "Smart")

(define-xml theme "theme")
(define-xml name "name")
(define-xml title-layout "titleLayout")
(define-xml keep-border "keepBorder")
(define-xml animate-iconify "animateIconify")
(define-xml font-active-window "<font place=\"ActiveWindow\">" "</font>")
(define-xml font-inactive-window "<font place=\"InactiveWindow\">" "</font>")
(define-xml font-menu-header "<font place=\"MenuHeader\">" "</font>")
(define-xml font-menu-item "<font place=\"MenuItem\">" "</font>")
(define-xml font-onscreen-display "<font place=\"OnScreenDisplay\">" "</font>")
(define-xml font-on-screen-display "<font place=\"OnScreenDisplay\">" "</font>")
(define-xml-num size "size")
(define-xml weight "weight")
(define-xml slant "slant")

(define bold "bold")
(define italic "italic")
(define normal "normal")

(define-xml desktops "desktops")
(define-xml-num number "number")
(define-xml-num firstdesk "firstdesk")
(define-xml-num first-desk "firstdesk")
(define-xml-num popup-time "popupTime")
(define (names . name-list)
  `("<names>"
    ,@(map name name-list)
    "</names>"))

(define-xml resize "resize")
(define-xml draw-contents "drawContents")
(define-xml popup-show "popupShow")
(define-xml popup-position "popupPosition")
(define-xml popup-position-fixed "popupPositionFixed")
(define-xml-num x "x")
(define-xml-num y "y")
(define x-center "<x>center</x>")
(define y-center "<y>center</y>")

(define always "Always")
(define never "Never")
(define nonpixel "Nonpixel")
(define non-pixel "Nonpixel")

(define top "Top")
(define centered "Center")
(define fixed "Fixed")

(define-xml applications "applications")
(define (application attrs . sub-nodes)
  (let
      ([class class-attr]
       [name  name-attr ]
       [role  role-attr ]
       [title title-attr]
       [type  type-attr ])
  `(,(string-append "<application "
                    (apply string-append attrs) ">")
    ,@sub-nodes
    "</application>")))
(define-xml-num desktop "desktop")
(define all-desktops "<desktop>all</desktop>")
(define desktop-all "<desktop>all</desktop>")
(define-xml layer "layer")
(define-xml decor "decor")
(define-xml maximized "maximized")

(define (class-attr x)
  (string-append "class=\"" x "\""))
(define (name-attr x)
  (string-append "name=\"" x "\""))
(define (role-attr x)
  (string-append "role=\"" x "\""))
(define (title-attr x)
  (string-append "title=\"" x "\""))
(define (type-attr x)
  (string-append "type=\"" x "\""))
(define above "above")
(define below "below")

(define-xml keyboard "keyboard")
(define-xml rebind-on-mapping-notify "rebindOnMappingNotify")
(define-xml chain-quit-key "chainQuitKey")
(define (keybind keys . actions)
  `(,(string-append "<keybind key=\"" keys "\">")
    ,@actions
    "</keybind>"))
(define (keybind-chroot keys . actions)
  `(,(string-append "<keybind key=\"" keys "\" chroot=\"true\">")
    ,@actions
    "</keybind>"))

(define (S . keys)
  (apply string-append (cons "S-" keys)))
(define (C . keys)
  (apply string-append (cons "C-" keys)))
(define (A . keys)
  (apply string-append (cons "A-" keys)))
(define (W . keys)
  (apply string-append (cons "W-" keys)))
(define (M . keys)
  (apply string-append (cons "M-" keys)))
(define (H . keys)
  (apply string-append (cons "H-" keys)))
(define (both bind1 bind2)
  (string-append bind1 " " bind2))

(define-xml mouse "mouse")
(define (context mname . sub-nodes)
  `(,(string-append "<context name=\"" mname "\">")
    ,@sub-nodes
    "</context>"))
(define (mousebind button action . sub-nodes)
  `(,(string-append "<mousebind button=\"" button "\" action=\"" action "\">")
    ,@sub-nodes
    "</mousebind>"))

(define left "Left")
(define right "Right")
(define middle "Middle")
(define up "Up")
(define down "Down")

(define press "Press")
(define click "Click")
(define double-click "DoubleClick")
(define release "Release")
(define drag "Drag")

(define (action name . args)
  `(,(string-append "<action name=\"" name "\">")
    ,@args
    "</action>"))

(define-syntax define-action
  (syntax-rules ()
    [(_ action-name action-string)
     (define (action-name . args)
       `(,(string-append "<action name=\"" name "\">")
         ,@args
         "</action>"))]))

(define-xml command "command")
(define-xml prompt "prompt")
(define-xml startup-notify "startupnotify")
(define-xml startupnotify "startupnotify")
(define-xml enabled "enabled")
(define-xml icon "icon")
(define-xml wm-class "wmclass")
(define-xml wmclass "wmclass")

(define-syntax execute
  (syntax-rules ()
    [(_ cmd)
     (action "Execute" (command cmd))]
    [(_ (pre ...) cmd)
     (action "Execute" pre ... (command cmd))]))

(define-xml menu "menu")
(define-xml position "position")
(define-xml-num monitor "monitor")
(define monitor-default "<monitor>default</monitor>")
(define monitor-primary "<monitor>primary</monitor>")
(define monitor-active "<monitor>active</monitor>")
(define monitor-mouse "<monitor>mouse</monitor>")
(define monitor-all "<monitor>all</monitor>")

(define-action show-menu "ShowMenu")

(define-action next-window "NextWindow")
(define-action previous-window "PreviousWindow")
(define-xml dialog "dialog")
(define list-dialog (dialog "list"))
(define icon-dialog (dialog "icons"))
(define none-dialog (dialog "none"))
(define-xml bar "bar")
(define-xml raise "raise")
(define-xml all-desktops "allDesktops")
(define-xml panels "panels")
(define-xml linear "linear")
(define-xml interactive "interactive")
(define-xml finalactions "finalactions")
(define-xml final-actions "finalactions")

(define-action directional-cycle-windows "DirectionalCycleWindows")
(define-action directional-target-window "DirectionalTargetWindow")
(define-xml direction "direction")

(define north "north")
(define south "south")
(define east "east")
(define west "west")
(define northeast "northeast")
(define southeast "southeast")
(define northwest "northwest")
(define southeast "southeast")

(define-action goto-desktop "GoToDesktop")
(define-action go-to-desktop "GoToDesktop")
(define-xml-num to "to")
(define-xml wrap "wrap")

(define-action add-desktop "AddDesktop")
(define-action remove-desktop "RemoveDesktop")
(define-xml where "where")

(define current "current")
(define last "last")

(define-action toggle-show-desktop "ToggleShowDesktop")
(define-xml strict "strict")

(define-action toggle-dock-autohide "ToggleDockAutohide")
(define-action reconfigure "Reconfigure")
(define-action restart "Restart")
(define-action exit "Exit")
(define-action session-logout "SessionLogoout")

(define-action debug "Debug")
(define-xml string "string")
;; TODO: create all of http://openbox.org/wiki/Help:Actions
