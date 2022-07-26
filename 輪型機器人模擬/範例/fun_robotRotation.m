function wRL=fun_robotRotation(dtime, dtheta, Rw)
  global L
  global r
  RLW = (2*Rw+L)/(2*Rw-L);
  wB = dtheta/dtime*L/r;
  wRL(1) = wB/(1-RLW);    %right wheel
  wRL(2) = RLW*wB/(1-RLW);%left  wheel