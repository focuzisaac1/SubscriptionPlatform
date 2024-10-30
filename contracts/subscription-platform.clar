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
