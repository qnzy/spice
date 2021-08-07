* spice model for a NE555 timer
.subckt ne555 gnd trig out resetn ctrl thr dis vcc
.param rdis = 10
.param rdiv = 100k
.param kcomp = 1e4
r1 vcc ctrl {rdiv}
r2 ctrl vcc_div_3 {rdiv}
r3 vcc_div_3 gnd {rdiv}
b1 ff_reset gnd V = V(vcc)*(tanh(kcomp*(V(thr)-V(ctrl)))+1)/2
b2 ff_set gnd V = V(vcc)*(tanh(kcomp*(V(vcc_div_3)-V(trig)))+1)/2
b3 ff_int gnd V = V(resetn) < V(vcc)/2 ? V(vcc) :
+             V(ff_reset) > V(vcc)/2 ? V(vcc) :
+             V(ff_set) > V(vcc)/2 ? 0 : V(ff_out)
r4 ff_int ff_out 1
c1 ff_out gnd 1p IC=0
b4 out gnd V = V(vcc)-V(ff_out)
b5 dis gnd I = V(ff_out) > V(vcc)/2 ? V(dis)/{rdis} : 0
rp1 trig gnd 10G
rp2 thr gnd 10G
rp3 resetn vcc 10G
.ends
