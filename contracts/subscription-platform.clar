;; Define data types
(define-data-var subscriptions (map 'principal (list 'content-id 'expiration-block 'payment-amount)) (map))
(define-data-var creator-royalties (map 'content-id 'royalty-percentage) (map))
(define-data-var creator-earnings (map 'principal (map 'content-id 'earnings)) (map))

;; Subscribe to content
(define-public (subscribe (content-id 'content-id) (payment-amount 'uint128))
  (let ((subscriber tx-sender)
        (expiration-block (+ block-height 2102400))) ; 2 years
    (map-insert subscriptions subscriber (list content-id expiration-block payment-amount))
    (ok expiration-block)))

;; Withdraw earnings
(define-public (withdraw (content-id 'content-id))
  (let ((principal tx-sender)
        (earnings (default-to 0 (get (get principal (map-get? creator-earnings principal)) content-id))))
    (if (> earnings 0)
        (begin
          (map-delete creator-earnings principal content-id)
          (as-contract (stx-transfer? earnings principal)))
        (err u0))))

;; Set royalty percentage
(define-public (set-royalty (content-id 'content-id) (royalty-percentage 'uint8))
  (map-insert creator-royalties content-id royalty-percentage)
  (ok royalty-percentage))

;; Report earnings
(define-public (report-earnings (content-id 'content-id) (earnings 'uint128))
  (let ((principal tx-sender)
        (current-earnings (default-to 0 (get (get principal (map-get? creator-earnings principal)) content-id)))
        (royalty-percentage (default-to 0 (map-get? creator-royalties content-id))))
    (map-set creator-earnings principal (insert (get principal (map-get? creator-earnings principal)) content-id (+ current-earnings (/ (* earnings royalty-percentage) 100))))
    (ok current-earnings)))
