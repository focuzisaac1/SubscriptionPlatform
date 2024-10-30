;; Define data types
(define-data-var subscriptions (map 'principal (list 'content-id 'expiration-block 'payment-amount)) (map))
(define-data-var creator-royalties (map 'content-id 'royalty-percentage) (map))
(define-data-var creator-earnings (map 'principal (map 'content-id 'earnings)) (map))
