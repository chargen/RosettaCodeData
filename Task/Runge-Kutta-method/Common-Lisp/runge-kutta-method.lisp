(defun runge-kutta (f x y x-end n)
    (let ((h (float (/ (- x-end x) n) 1d0))
          k1 k2 k3 k4)
        (setf x (float x 1d0)
              y (float y 1d0))
        (cons (cons x y)
            (loop for i below n do
                (setf k1 (* h (funcall f x y))
                      k2 (* h (funcall f (+ x (* 0.5d0 h)) (+ y (* 0.5d0 k1))))
                      k3 (* h (funcall f (+ x (* 0.5d0 h)) (+ y (* 0.5d0 k2))))
                      k4 (* h (funcall f (+ x h) (+ y k3)))
                      x (+ x h)
                      y (+ y (/ (+ k1 k2 k2 k3 k3 k4) 6)))
                collect (cons x y)))))

(let ((sol (runge-kutta (lambda (x y) (* x (sqrt y))) 0 1 10 100)))
    (loop for n from 0
          for (x . y) in sol
          when (zerop (mod n 10))
          collect (list x y (- y (/ (expt (+ 4 (* x x)) 2) 16)))))

((0.0d0 1.0d0 0.0d0)
 (0.9999999999999999d0 1.562499854278108d0 -1.4572189210859676d-7)
 (2.0000000000000004d0 3.9999990805207988d0 -9.194792029987298d-7)
 (3.0000000000000013d0 10.562497090437557d0 -2.9095624576314094d-6)
 (4.000000000000002d0 24.999993765090643d0 -6.234909392333066d-6)
 (4.999999999999998d0 52.56248918030259d0 -1.081969734428867d-5)
 (5.999999999999995d0 99.9999834054036d0 -1.659459609015812d-5)
 (6.999999999999991d0 175.56247648227117d0 -2.3517728038768837d-5)
 (7.999999999999988d0 288.9999684347983d0 -3.156520000402452d-5)
 (8.999999999999984d0 451.56245927683887d0 -4.072315812209126d-5)
 (9.99999999999998d0 675.9999490167083d0 -5.0983286655537086d-5))
