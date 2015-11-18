from math import sqrt

def rk4(f, x0, y0, x1, n):
    vx = [0]*(n + 1)
    vy = [0]*(n + 1)
    h = (x1 - x0)/n
    vx[0] = x = x0
    vy[0] = y = y0
    for i in range(1, n + 1):
        k1 = h*f(x, y)
        k2 = h*f(x + 0.5*h, y + 0.5*k1)
        k3 = h*f(x + 0.5*h, y + 0.5*k2)
        k4 = h*f(x + h, y + k3)
        vx[i] = x = x0 + i*h
        vy[i] = y = y + (k1 + k2 + k2 + k3 + k3 + k4)/6
    return vx, vy

def f(x, y):
    return x*sqrt(y)

vx, vy = rk4(f, 0, 1, 10, 100)
for x, y in list(zip(vx, vy))[::10]:
    print(x, y, y - (4 + x*x)**2/16)

0 1 0.0
1.0 1.562499854278108 -1.4572189210859676e-07
2.0 3.9999990805207997 -9.194792003341945e-07
3.0 10.562497090437551 -2.9095624487496252e-06
4.0 24.999993765090636 -6.234909363911356e-06
5.0 52.562489180302585 -1.0819697415342944e-05
6.0 99.99998340540358 -1.659459641700778e-05
7.0 175.56247648227125 -2.3517728749311573e-05
8.0 288.9999684347986 -3.156520142510999e-05
9.0 451.56245927683966 -4.07231603389846e-05
10.0 675.9999490167097 -5.098329029351589e-05
