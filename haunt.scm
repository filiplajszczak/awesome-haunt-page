(use-modules (haunt asset)
             (haunt page)
             (haunt html)
             (haunt post)
             (haunt site)
             (commonmark))

(define (base-template body)
   `((doctype html)
     (head
       (meta (@ (charset "utf-8")))
       (meta (@ (name "viewport")
                (content "width=device-width, initial-scale=1")))
       (title "Awesome Haunt")
       ;; css
       (link (@ (rel "stylesheet")
                (href "https://unpkg.com/terminal.css@0.7.2/dist/terminal.min.css")))
       (body (@ (class "terminal"))
             (div (@ (class "container"))
                  ,body)))))

(define index-sxml
  (call-with-input-file "readme.md"
    (lambda (port)
      (commonmark->sxml port))))

(define (index-page site posts)
  (make-page "index.html"
             (base-template index-sxml)
             sxml->html))

(site #:title "awesome.haunt.page"
      #:domain "awesome.haunt.page"
      #:default-metadata
      '((author . "filip lajszczak")
        (email  . "filip@lajszczak.dev"))
      #:readers (list)
      #:builders (list index-page))

