* ngspice model for a NE555 timer
.subckt ne555 gnd trig out resetn ctrl thr dis vcc
.param rdis = 10
.param rdiv = 100k
.param kcomp = 1e4
r1 vcc ctrl {rdiv}
r2 ctrl vcc_div_3 {rdiv}
r3 vcc_div_3 gnd {rdiv}
b1 ff_reset gnd V = V(vcc)*(tanh(kcomp*(V(thr)-V(ctrl)))+1)/2
b2 ff_set gnd V = V(vcc)*(tanh(kcomp*(V(vcc_div_3)-V(trig)))+1)/2
b3 ff_outn gnd V = time == 0 ? 0 :
+             V(resetn) < V(vcc)/2 ? V(vcc) :
+             V(ff_reset) > V(vcc)/2 ? V(vcc) :
+             V(ff_set) > V(vcc)/2 ? 0 : 
+             V(ff_outn) > V(vcc)/2 ? V(vcc) : 0
b4 out gnd V = V(vcc)-V(ff_outn)
b5 dis gnd I = V(ff_outn) > V(vcc)/2 ? V(dis)/{rdis} : 0
.ends
