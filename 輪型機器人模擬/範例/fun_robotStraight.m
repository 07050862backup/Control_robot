function wRL=fun_robotStraight(dtime, distance)
  global r
  wB = distance/dtime*2/r;
  wRL(1) = wB/2;    %right wheel
  wRL(2) = wB/2;    %left  wheel