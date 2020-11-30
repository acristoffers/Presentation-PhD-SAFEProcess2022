#!/usr/bin/env python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

import modern_control as mc

matplotlib.rcParams['savefig.pad_inches'] = 0
ax = plt.axes([0, 0, 1, 1], frameon=False)
ax.get_xaxis().set_visible(False)
ax.get_yaxis().set_visible(False)
plt.autoscale(tight=True)

x0 = [[0], [0]]
u0 = [[0]]

wn = 1

for zeta in [0.5, 0.75, 1]:
    a = 2 * zeta * wn
    b = wn**2
    A, B, C, D = [[0, 1], [-b, -a]], [[0], [1]], [[b, 0]], [[0]]
    G = mc.CStateSpace(A, B, C, D, x0, u0).system_state([0, 0])
    ys = G.sim_step(1, 50)
    ts = [t for t, _ in ys]
    xs = [(np.array(C)@x).item() for _, x in ys]
    plt.plot(ts, xs)

plt.plot(ts, np.asarray(ts) * 0 + 1.2, 'w')
plt.axis('off')
plt.savefig('cover.pdf', bbox_inches='tight', pad_inches=0, transparent=True)
