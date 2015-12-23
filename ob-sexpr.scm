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

(define-xml desktops "desktops")
(define-xml-num number "number")
(define-xml-num firstdesk "firstdesk")
(define-xml-num first-desk "firstdesk")
(define-xml-num popup-time "popupTime")
(define-xml names "names")

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
